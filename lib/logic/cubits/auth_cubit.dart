import 'dart:async';
import 'package:chat_app/data/repositories/auth_repo.dart';
import 'package:chat_app/logic/cubits/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit({required AuthRepo authRepository})
    : _authRepository = authRepository,
      super(const AuthState()) {
    _init();
  }

  void _init() {
    emit(state.copyWith(status: AuthStatus.initial));

    _authStateSubscription = _authRepository.authStateChanges.listen((
      user,
    ) async {
      if (user != null) {
        try {
          final userData = await _authRepository.getUserData(user.uid);
          emit(
            state.copyWith(status: AuthStatus.authenticated, user: userData),
          );
        } catch (e) {
          emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
        }
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final user = await _authRepository.signUp(
        fullName: fullName,
        userName: userName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
 
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}
