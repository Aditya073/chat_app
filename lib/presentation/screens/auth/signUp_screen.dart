import 'package:chat_app/core/common/custom_text_field.dart';
import 'package:chat_app/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController newName = TextEditingController();
  final TextEditingController newUsername = TextEditingController();
  final TextEditingController newEmailID = TextEditingController();
  final TextEditingController newPhonenumber = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  @override
  void dispose() {
    newName.dispose();
    newUsername.dispose();
    newEmailID.dispose();
    newPhonenumber.dispose();
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        // text  (Name)
                        margin: EdgeInsets.only(top: 30, left: 15, bottom: 15),
                        child: TextWidget(text: 'Full name'),
                      ),
                      CustomTextField(
                        controller: newName,
                        hintText: '',
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
                      Container(
                        // text  (Name)
                        margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
                        child: TextWidget(text: 'Username'),
                      ),
                      CustomTextField(
                        controller: newUsername,
                        hintText: '',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),

                      Container(
                        // text  (Email)
                        margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
                        child: TextWidget(text: 'Email'),
                      ),
                      CustomTextField(
                        controller: newEmailID,
                        hintText: '',
                        prefixIcon: Icon(Icons.mail_outline_outlined),
                      ),
                      Container(
                        // text  (Email)
                        margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
                        child: TextWidget(text: 'Phone number'),
                      ),
                      CustomTextField(
                        controller: newPhonenumber,
                        hintText: '',
                        keyboardType: TextInputType.numberWithOptions(),
                        prefixIcon: Icon(Icons.phone),
                      ),

                      Container(
                        // text  (Password)
                        margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
                        child: TextWidget(text: 'Password'),
                      ),

                      CustomTextField(
                        controller: newPassword,
                        hintText: '',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        obscureText: true,
                        suffixIcon: Icon(Icons.visibility),
                      ),

                      SizedBox(height: 20),
                      Center(
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),

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
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    ' Sign Ip Now!',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
