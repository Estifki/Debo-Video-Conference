import 'dart:async';

import '/const/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network_helper/google_auth.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 1800),
      () => Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => GoogleAuth().authCheck(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: baseColor,
      body: Stack(children: [
        Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  baseColor.withOpacity(0.85),
                  baseColor.withOpacity(0.9),
                  baseColor.withOpacity(1)
                ]),
          ),
          child: Center(
            child: Hero(
              tag: "INSA",
              child: Container(
                height: 100,
                width: 106,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/deboLogo.png"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: MediaQuery.of(context).size.width * 0.03,
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "INSA",
              style: TextStyle(
                  letterSpacing: 4,
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                  color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
