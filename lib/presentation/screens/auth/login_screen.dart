import 'package:chat_app/Pages/home.dart';
import 'package:chat_app/core/common/custom_text_field.dart';
import 'package:chat_app/data/repositories/auth_repo.dart';
import 'package:chat_app/presentation/screens/auth/signUp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final userEmailID = TextEditingController();
  final userPassword = TextEditingController();

  bool _isPasswordVisibal = true;

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  Future<void> handleSignIn() async {
    // First we check if all the Textfields are field with valid info
    FocusScope.of(context).unfocus();
    if (_formkey.currentState?.validate() ?? false) {
      // then we call the "AuthRepo()" class to access the "signIn()" method
      final exestingUser = await AuthRepo().signIn(
        email: userEmailID.text.trim(),
        password: userPassword.text.trim(),
      );
      if (exestingUser == "User not found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("User not found", style: TextStyle(fontSize: 20)),
          ),
        );
      } else {
        print(exestingUser.fullName);
        print(exestingUser.userName);
        print(exestingUser.email);
        print(exestingUser.phoneNumber);
        print(exestingUser.password);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text('Login Successfully', style: TextStyle(fontSize: 20)),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    }
  }

  @override
  void dispose() {
    userEmailID.dispose();
    userPassword.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                // to overlap the containers
                children: [
                  Container(
                    // Design of the container
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.deepPurple.shade700,
                          Colors.deepPurple.shade500,
                          Colors.blueAccent.shade400,
                          Colors.blueAccent.shade200,
                        ],
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width,
                          120,
                        ),
                      ),
                    ),

                    // main content of the container
                    child: SafeArea(
                      child: Column(
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            'Login to your account',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    // Design of the container
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5.0,
                      left: 20,
                      right: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                    // height: MediaQuery.of(context).size.height / 2.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 238, 238),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    // main content of the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // text  (Email)
                          margin: EdgeInsets.only(
                            top: 40,
                            left: 15,
                            bottom: 15,
                          ),
                          child: TextWidget(text: 'Email'),
                        ),
                        CustomTextField(
                          controller: userEmailID,
                          hintText: '',
                          focusNode: _emailFocus,
                          validator: _validateEmail,
                          prefixIcon: Icon(Icons.mail_outline),
                        ),

                        Container(
                          // text  (Password)
                          margin: EdgeInsets.only(
                            top: 20,
                            left: 15,
                            bottom: 15,
                          ),
                          child: TextWidget(text: 'Password'),
                        ),
                        CustomTextField(
                          controller: userPassword,
                          hintText: '',
                          focusNode: _passwordFocus,
                          validator: _validatePassword,
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          obscureText: _isPasswordVisibal,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisibal = !_isPasswordVisibal;
                              });
                            },
                            icon: _isPasswordVisibal
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.deepPurple.shade300,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),

                            child: GestureDetector(
                              onTap: () {
                                handleSignIn();
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 30,
                                  right: 30,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xff6380fb),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' Sign Up Now!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          FocusScope.of(context).unfocus();
                          if (_formkey.currentState?.validate() ?? false) {}

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  String text;
  TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }
}
