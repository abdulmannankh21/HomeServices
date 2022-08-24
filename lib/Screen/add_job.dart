import 'package:flutter/material.dart';
import 'package:homeservices/Screen/postjob_details.dart';

class AddJob extends StatefulWidget {
  const AddJob({Key? key}) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text(
          "Servo",
        ),
      ),
      body: Column(

        children: [
          Image.asset(
            'assets/homepic.jpg',
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              height: size.height * 0.2,
              width: size.width * 0.42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.amber,
              ),
              child: InkWell(
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => PostJobDetails()));
                },
                child: Center(
                  child: Text(
                    "Add Job",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
