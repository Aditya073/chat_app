
import 'package:chat_app/data/repositories/auth_repo.dart';
import 'package:chat_app/data/repositories/chat_repo.dart';
import 'package:chat_app/data/repositories/contact_repo.dart';
import 'package:chat_app/logic/chat/chat_cubit.dart';
import 'package:chat_app/logic/cubits/auth_cubit.dart';
import 'package:chat_app/presentation/screens/auth/firebase_options.dart';
import 'package:chat_app/router/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;


Future<void> setupServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  getIt.registerLazySingleton(() => AuthRepo());
  getIt.registerLazySingleton(() => ContactRepo());
  getIt.registerLazySingleton(() => ChatRepo());

  getIt.registerLazySingleton(
    () => AuthCubit(authRepository: getIt<AuthRepo>()),
  );
}
