import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff553370),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.only(left: 5),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                      size: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Text(
                    'Person 1',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
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
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(
                          top: 30,
                          right: 10,
                          left: MediaQuery.of(context).size.width / 2,
                        ),
                        padding: EdgeInsets.all(8),
                        // width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 236, 240),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.zero,
                          ),
                        ),
                        child: Text(
                          'Hello, what are u doing?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          top: 5,
                          right: MediaQuery.of(context).size.width / 2,
                          left: 10,
                        ),
                        padding: EdgeInsets.all(8),
                        // width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 211, 228, 243),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'I am good!!!, but what about u?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Spacer(),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            right: 10,
                            left: 10,
                          ),
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hint: Text(
                                      'Type a message',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // suffixIcon: Icon(Icons.send, color: Colors.grey),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                // color: Colors.grey.shade500,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.send, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
