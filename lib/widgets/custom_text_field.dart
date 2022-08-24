import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hint;
  final TextInputType inputType;
  final bool obstext;
  final TextEditingController controller;
  final String? Function(dynamic value) validator;
  final String? Function(dynamic value) onSaved;
  final TextInputAction textInputAction;

  CustomTextfield(
      {Key? key,
      required this.inputType,
      required this.hint,
      required this.obstext,
      required TextEditingController this.controller,
      required String? Function(dynamic value) this.validator,
      required String? Function(dynamic value) this.onSaved,
      required TextInputAction this.textInputAction})
      : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 1, color: Colors.black, style: BorderStyle.solid)),
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.inputType,
          obscureText: widget.obstext,
          decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.all(15),
              border: InputBorder.none),
          onChanged: (value) {
            // Do something
          },
          validator: (value){

          },
          onSaved: (value){

          },
        ),
      ),
    );
  }
}
