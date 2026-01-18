import 'package:chat_app/Pages/home.dart';
import 'package:chat_app/core/common/custom_text_field.dart';
import 'package:chat_app/data/repositories/auth_repo.dart';
import 'package:chat_app/presentation/screens/auth/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController newName = TextEditingController();
  final TextEditingController newUsername = TextEditingController();
  final TextEditingController newEmailID = TextEditingController();
  final TextEditingController newPhonenumber = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  bool _isPasswordVisibal = true;

  final _nameFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    newName.dispose();
    newUsername.dispose();
    newEmailID.dispose();
    newPhonenumber.dispose();
    _nameFocus.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Name';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Username';
    }
    return null;
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

  // Phone validation
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +1234567890)';
    }
    return null;
  }

  Future<void> handleSignUp() async {
    // First we check if all the Textfields are field with valid info
    FocusScope.of(context).unfocus();
    if (_formkey.currentState?.validate() ?? false) {
      // then we call the "AuthRepo()" class to access the "signUp()" method
      final newUser = await AuthRepo().signUp(
        fullName: newName.text,
        userName: newUsername.text,
        email: newEmailID.text,
        phoneNumber: newPhonenumber.text.trim(),
        password: newPassword.text.trim(),
      );

      if (newUser == "Failed to create user" ||
          newUser == "User already exists") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "User Already exesists",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      } else {
        print(newUser.fullName);
        print(newUser.userName);
        print(newUser.email);
        print(newUser.phoneNumber);
        print(newUser.password);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    }
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
                            'Sign Up',
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
                          // text  (Full Name)
                          margin: EdgeInsets.only(
                            top: 10,
                            left: 15,
                            bottom: 15,
                          ),
                          child: TextWidget(text: 'Full name'),
                        ),
                        CustomTextField(
                          controller: newName,
                          focusNode: _nameFocus,
                          validator: _validateName,
                          hintText: '',
                          prefixIcon: Icon(Icons.person_2_outlined),
                        ),

                        Container(
                          // text  (Username)
                          margin: EdgeInsets.only(
                            top: 20,
                            left: 15,
                            bottom: 15,
                          ),
                          child: TextWidget(text: 'Username'),
                        ),
                        CustomTextField(
                          controller: newUsername,
                          hintText: '',
                          focusNode: _usernameFocus,
                          validator: _validateUsername,
                          prefixIcon: Icon(Icons.alternate_email),
                        ),

                        Container(
                          // text  (Email)
                          margin: EdgeInsets.only(
                            top: 20,
                            left: 15,
                            bottom: 15,
                          ),
                          child: TextWidget(text: 'Email'),
                        ),
                        CustomTextField(
                          controller: newEmailID,
                          hintText: '',
                          focusNode: _emailFocus,
                          validator: _validateEmail,
                          prefixIcon: Icon(Icons.mail_outline_outlined),
                        ),

                        Container(
                          // text  (Phone number)
                          margin: EdgeInsets.only(
                            top: 20,
                            left: 15,
                            bottom: 15,
                          ),
                          child: TextWidget(text: 'Phone number'),
                        ),
                        CustomTextField(
                          controller: newPhonenumber,
                          hintText: '',
                          keyboardType: TextInputType.numberWithOptions(),
                          focusNode: _phoneFocus,
                          validator: _validatePhone,
                          prefixIcon: Icon(Icons.phone),
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
                          controller: newPassword,
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

                        SizedBox(height: 20),
                        Center(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),

                            child: GestureDetector(
                              onTap: () {
                                // calling the Signup function
                                handleSignUp();
                                // CircularProgressIndicator();
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
                                  'Sign Up',
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
              SizedBox(height: 10),

              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' Sign In Now!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
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
