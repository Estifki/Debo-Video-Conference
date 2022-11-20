import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
 final  double width;
  final Color textColor;

  final VoidCallback onpressed;
  const CustomButton(
      {Key? key,
      required this.label,
      required this.textColor,
      required this.backgroundColor,
      required this.width,
      required this.onpressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 45,
      width: screenSize.width * width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            onPrimary: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        onPressed: onpressed,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
