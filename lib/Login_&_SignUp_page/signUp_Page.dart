import 'package:chat_app/Login_&_SignUp_page/login_Page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                        // text  (Name)
                        margin: EdgeInsets.only(top: 40, left: 15, bottom: 15),
                        child: TextWidget(text: 'Name'),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 10,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Colors.deepPurple.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: TextField(
                          // Textfield  (Name)
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person_2_outlined,
                              color: Colors.deepPurple.shade300,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // text  (Email)
                        margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
                        child: TextWidget(text: 'Email'),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 10,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Colors.deepPurple.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: TextField(
                          // Textfield  (Email)
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Colors.deepPurple.shade300,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        // text  (Password)
                        margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
                        child: TextWidget(text: 'Password'),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 25,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Colors.deepPurple.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: TextField(
                          // Textfield  (Password)
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Colors.deepPurple.shade300,
                            ),
                          ),
                          obscureText: true, // Doesn't show the password
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
