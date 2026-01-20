import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/config/theme/app_theme.dart';
import 'package:chat_app/logic/cubits/auth_cubit.dart';
import 'package:chat_app/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Future<void> handleSignOut() async {
  //   context.read<AuthCubit>().signOut();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Chat Up',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        // Search for a person
                      },
                      icon: Icon(
                        Icons.search,
                        size: 24,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  // Container design
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Logout
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<AuthCubit>().signOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.logout_rounded,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // child: Column(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(top: 25, right: 15, left: 15),
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => ChatPage(),
                  //             ),
                  //           );
                  //         },
                  //         child: Row(
                  //           // person 1
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(20),
                  //               child: Image.asset(
                  //                 'images/Person_1.jpg',
                  //                 height: 70,
                  //                 width: 70,
                  //                 fit: BoxFit.contain,
                  //               ),
                  //             ),

                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 5),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Person 1',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 18,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     'Hello, what are u doing?',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 14,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             Text(
                  //               '04:35 PM',
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 16,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.only(top: 30, right: 15, left: 15),
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => ChatPage(),
                  //             ),
                  //           );
                  //         },
                  //         child: Row(
                  //           // person 2
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(20),
                  //               child: Image.asset(
                  //                 'images/Person_2.jpg',
                  //                 height: 70,
                  //                 width: 70,
                  //                 fit: BoxFit.contain,
                  //               ),
                  //             ),

                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 5),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Person 2',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 18,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     'Hey there!!!',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 14,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             Text(
                  //               '05:07 PM',
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 16,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.message_rounded, color: Colors.white, size: 30),
      ),
    );
  }
}
