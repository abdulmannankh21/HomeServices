import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeservices/Screen/add_job.dart';
import 'package:homeservices/Screen/jobs_list.dart';
import 'package:homeservices/Screen/profile.dart';

import 'chatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  showInSnackBar({required String message, required context}) {
    final snackBar = SnackBar(content: Text(message, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)), elevation: 10, duration: const Duration(seconds: 2), margin: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), behavior: SnackBarBehavior.floating, backgroundColor: Colors.amber.shade50,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: const Text(
          "Servo",
        ),
      ),
      body:  Column(
        children: [
          Image.asset(
            'assets/homepic.jpg',
          ),
          SizedBox(
            height: size.height * 0.07,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => JobsList()));
                        },
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: size.height /6,
                            width: size.width /3,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ProfileScreen()));
                        },
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(25),

                            child: Container(
                              height: size.height /6,
                              width: size.width /3,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 45,
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
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AddJob()));
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: size.height /6,
                        width: size.width /3,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_sharp,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (ctx) => ProfileScreen()));
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: size.height /6,
                        width: size.width /3,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.chat,
                            color: Colors.white,
                            size: 45,
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
      ),
    );
  }
}
