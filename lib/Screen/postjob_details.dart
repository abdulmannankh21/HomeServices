import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeservices/Screen/home.dart';
import 'package:homeservices/widgets/custom_text_field.dart';

class PostJobDetails extends StatefulWidget {
  const PostJobDetails({Key? key}) : super(key: key);

  @override
  State<PostJobDetails> createState() => _PostJobDetailsState();
}

class _PostJobDetailsState extends State<PostJobDetails> {
  var jobtitle;
  var jobdiscription;
  var hourlyrate;
  var agents;
  var hours;
  var email;
  var location;
  var datetime;

  final TextEditingController titlejobController = new TextEditingController();
  final TextEditingController jobdiscriptionController =
      new TextEditingController();
  final TextEditingController hourlyrateController =
      new TextEditingController();
  final TextEditingController agentsController = new TextEditingController();
  final TextEditingController hoursController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    onDateTimeChanged:
    (DateTime newDateTime) {
      setState(() => dateTime = newDateTime);
    };
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titlejobController.dispose();
    jobdiscriptionController.dispose();
    hourlyrateController.dispose();
    hoursController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  clearText() {
    titlejobController.clear();
    jobdiscriptionController.clear();
    hourlyrateController.clear();
    hoursController.clear();
    emailController.clear();
    agentsController.clear();
    locationController.clear();
  }

// Adding Job Post
  CollectionReference Job = FirebaseFirestore.instance.collection('job');

  Future<void> addJobPost() {
    return Job.add({
      'id': Job.doc().id,
      'job title': jobtitle,
      'job discription': jobdiscription,
      'horly rate': hourlyrate,
      'hours': hours,
      'email': email,
      'location': location,
      'Agents': agents,
      'date time': datetime,
      'status': 'pending',
      'postedBy': FirebaseAuth.instance.currentUser!.uid
    })
        .then((value) => print('Job Added'))
        .catchError((error) => print('Failed to Add Job: $error'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoDatePicker.
    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: size.height / 3,
                padding: const EdgeInsets.only(top: 6.0),
                // The Bottom margin is provided to align the popup above the system navigation bar.
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                // Provide a background color for the popup.
                // color: CupertinoColors.systemBackground.resolveFrom(context),
                // Use a SafeArea widget to avoid system overlaps.
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: SafeArea(
                  top: false,
                  child: child,
                ),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text(
          "Servo",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                inputType: TextInputType.text,
                hint: 'Job Title',
                obstext: false,
                validator: (value) {},
                controller: titlejobController,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: Colors.black,
                        style: BorderStyle.solid)),
                child: TextFormField(
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Job Discription",
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                  controller: this.jobdiscriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty value";
                    }
                  },
                  onSaved: (value) {
                    jobdiscriptionController.text = value!;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                inputType: TextInputType.number,
                hint: 'Hourly Rate',
                obstext: false,
                validator: (value) {},
                controller: hourlyrateController,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                inputType: TextInputType.number,
                hint: 'Hours',
                obstext: false,
                validator: (value) {},
                controller: hoursController,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                inputType: TextInputType.emailAddress,
                hint: 'Email',
                obstext: false,
                validator: (value) {},
                controller: emailController,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: Colors.black,
                        style: BorderStyle.solid)),
                child: TextFormField(
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Location",
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                  controller: this.locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty value";
                    }
                  },
                  onSaved: (value) {
                    locationController.text = value!;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                inputType: TextInputType.number,
                hint: 'How Many Agents?',
                obstext: false,
                validator: (value) {},
                controller: agentsController,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Date & Time',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  CupertinoButton(
                    // Display a CupertinoDatePicker in dateTime picker mode.
                    onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: dateTime,
                        use24hFormat: false,
                        // This is called when the user changes the dateTime.
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(() => dateTime = newDateTime);
                        },
                      ),
                    ),

                    // In this example, time value is formatted manually. You can use intl package to
                    // format the value based on the user's locale settings.
                    child: Text(
                      '${dateTime.month}-${dateTime.day}-${dateTime.year}   |    ${dateTime.hour}:${dateTime.minute}',
                      style:
                          const TextStyle(fontSize: 22.0, color: Colors.amber),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    jobtitle = titlejobController.text;
                    jobdiscription = jobdiscriptionController.text;
                    hourlyrate = hourlyrateController.text;
                    hours = hoursController.text;
                    location = locationController.text;
                    agents = agentsController.text;
                    datetime = dateTime;
                    email = emailController.text;
                    addJobPost();
                    Fluttertoast.showToast(
                        msg: "Job Posted Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    clearText();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  });
                },
                child: Center(
                  child: Container(
                    width: size.width,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "Post Job",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
