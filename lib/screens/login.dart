import 'package:debo_01/network_helper/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_screen.dart';
import '/const/colors.dart';
import '../widgets/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                baseColor.withOpacity(0.75),
                baseColor.withOpacity(0.85),
                baseColor.withOpacity(0.9),
                baseColor.withOpacity(1)
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(right: 10, top: screenSize.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Hero(
                    tag: "INSA",
                    child: Container(
                      height: 50,
                      width: 52,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/deboLogo.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.12),
              child: Container(
                height: screenSize.height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/onBoarding.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            AnimatedTextKit(
              totalRepeatCount: 1,
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Keeping you securely connected.',
                  speed: const Duration(milliseconds: 50),
                  textStyle: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            CustomButton(
              width: 0.8,
              onpressed: () => GoogleAuth().signInWithGoogle(),
              backgroundColor: customBlueColor,
              textColor: Colors.white,
              label: "Sign In with Gmail",
            ),
            const SizedBox(
              height: 16,
            ),
            // CustomButton(
            //   width: 0.8,
            //   onpressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const MainScreen(),
            //     ),
            //   ),
            //   backgroundColor: customPinkshColor,
            //   textColor: Colors.white,
            //   label: "30-days Free trial",
            // ),
          ],
        ),
      ),
    );
  }
}
