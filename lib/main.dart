import 'package:chat_app/presentation/home/home.dart';
import 'package:chat_app/config/theme/app_theme.dart';
import 'package:chat_app/data/repositories/auth_repo.dart';
import 'package:chat_app/logic/cubits/auth_cubit.dart';
import 'package:chat_app/presentation/screens/auth/firebase_options.dart';
import 'package:chat_app/presentation/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authRepository: AuthRepo(),
      ),
      child: MaterialApp(
        title: 'Chat App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
