import 'package:chat_app/Login_&_SignUp_page/firebase_options.dart';
import 'package:chat_app/Login_&_SignUp_page/login_Page.dart';
import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  } // 37:19
}
