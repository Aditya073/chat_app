import 'package:chat_app/config/theme/app_theme.dart';
import 'package:chat_app/data/repositories/auth_repo.dart';
import 'package:chat_app/data/repositories/chat_repo.dart';
import 'package:chat_app/logic/cubits/auth_cubit.dart';
import 'package:chat_app/logic/cubits/auth_state.dart';
import 'package:chat_app/logic/observer/app_life_cycle_observer.dart';
import 'package:chat_app/presentation/home/home.dart';
import 'package:chat_app/presentation/screens/auth/firebase_options.dart';
import 'package:chat_app/presentation/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {            // isOnline Status
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  late AppLifeCycleObserver _appLifeCycleObserver;

  @override
  void initState() {
    AuthCubit(authRepository: AuthRepo()).stream.listen((state) {
      if (state.status == AuthStatus.authenticated && state.user != null) {
        _appLifeCycleObserver = AppLifeCycleObserver(
          userId: state.user!.uid,
          chatRepo: ChatRepo(),
        );
      }
      WidgetsBinding.instance.addObserver(_appLifeCycleObserver);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository: AuthRepo()),
      child: MaterialApp(
        title: 'Chat App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          bloc: AuthCubit(authRepository: AuthRepo()),
          builder: (context, state) {
            if (state.status == AuthStatus.initial) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.status == AuthStatus.authenticated) {
              return Home();
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
