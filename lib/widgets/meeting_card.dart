import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MeetingCard extends StatelessWidget {
  Color color;
  Icon icon;
  String labelText;

  MeetingCard(
      {Key? key,
      required this.labelText,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 180,
      width: screenSize.width * 0.4,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // image: DecorationImage(
                  //   image: AssetImage(imgUrl),
                  // ),
                ),
                child: icon),
            const SizedBox(
              height: 8,
            ),
            Text(
              labelText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
