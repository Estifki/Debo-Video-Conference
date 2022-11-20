import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String labelText;
  String hintText;
  TextEditingController controller;

  CustomTextField({
    Key? key,
    required this.labelText,
    this.hintText = "",
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5, right: 18, left: 18),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.all(5),
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 58, 101, 172),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 102, 152, 233),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 58, 101, 172),
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 58, 101, 172),
            ),
          ),
        ),
      ),
    );
  }
}
