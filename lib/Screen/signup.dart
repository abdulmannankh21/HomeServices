import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeservices/widgets/custom_text_field.dart';
import 'package:homeservices/Screen/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController aboutController = new TextEditingController();
  final TextEditingController skilldetailController =
      new TextEditingController();

//Image Upload
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;


  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        Fluttertoast.showToast(msg: "No Image Found");
      }
    });
  }
  Future uploadImage() async{
    Reference ref =FirebaseStorage.instance.ref().child("images");
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    print(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text(
          "Servo",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/servoservice.png',
                    width: 100,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please Enter the Required Information Below",
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  imagePickerMethod();

                },
                child: _image == null
                    ? Center(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.amber,
                          child: Container(
                              height: size.width * 70,
                              width: size.width * 70,
                              padding: EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  ),
                              child: Center(child: Icon(Icons.add_a_photo,color: Colors.black,),)),
                        ),
                      )
                    : Center(
                        child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Color(0xffFDCF09),
                            child: Container(
                                height: size.width * 70,
                                width: size.width * 70,
                                padding: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellowAccent,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_image!),
                                    )),
                                child: Text(""))),
                      ),
              ),
              SizedBox(height: 20),
              CustomTextfield(
                controller: nameController,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{3,}$');
                  if (value!.isEmpty) {
                    return ("Name cannot be Empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid name(Min. 3 Character)");
                  }
                  return null;
                },
                onSaved: (value) {
                  nameController.text = value!;
                },
                textInputAction: TextInputAction.next,
                hint: 'Username',
                inputType: TextInputType.name,
                obstext: false,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                hint: 'Email',
                inputType: TextInputType.emailAddress,
                obstext: false,
                onSaved: (value) {
                  emailController.text = value!;
                },
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Your Email");
                  }
                  // reg expression for email validation
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please Enter a valid email");
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                hint: 'Password',
                inputType: TextInputType.text,
                obstext: true,
                onSaved: (value) {
                  passwordController.text = value!;
                },
                controller: passwordController,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return ("Password is required for login");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Password(Min. 6 Character)");
                  }
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                hint: 'Phone Number',
                inputType: TextInputType.phone,
                obstext: false,
                onSaved: (value) {
                  phoneController.text = value!;
                },
                controller: phoneController,
                validator: (value) {
                  validateMobile(value);
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: Colors.black,
                        style: BorderStyle.solid)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "About",
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                  controller: this.aboutController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty value";
                    }
                  },
                  onSaved: (value) {
                    aboutController.text = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
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
                      hintText: "Field Discription",
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                  controller: this.skilldetailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty value";
                    }
                  },
                  onSaved: (value) {
                    skilldetailController.text = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  register(emailController.text, passwordController.text);
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
                        "SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Create an account?',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      TextSpan(
                        text: ' Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // apiCalls();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => SignIn()));
                          },
                        style: TextStyle(color: Colors.amber, fontSize: 14),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(),
        uploadImage(),})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.Name = nameController.text;
    userModel.Phone = phoneController.text;
    userModel.About = aboutController.text;
    userModel.FieldDiscription = skilldetailController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
  }
}


String? validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}
