import 'package:debo_01/network_helper/google_auth.dart';

import 'package:debo_01/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../const/colors.dart';
import '../widgets/button.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Profile({Key? key}) : super(key: key);

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
        child: firebaseAuth.currentUser != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          userImage(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SelectableText(
                      userName(),
                      style:
                          const TextStyle(fontSize: 17.5, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: SelectableText(
                      userEmail(),
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.1),
                    child: CustomButton(
                        width: 0.8,
                        backgroundColor: customBlueColor,
                        label: "Sign Out",
                        textColor: Colors.white,
                        onpressed: () {
                          GoogleAuth().signOut();
                        }),
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Looks Like You Are Not Loged In!",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomButton(
                        width: 0.38,
                        label: "Login Now",
                        textColor: Colors.white,
                        backgroundColor: customBlueColor,
                        onpressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SpalshScreen(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  userName() {
    if (firebaseAuth.currentUser!.displayName != null) {
      return firebaseAuth.currentUser!.displayName!.toUpperCase();
    }
  }

  userEmail() {
    if (firebaseAuth.currentUser!.email != null) {
      return firebaseAuth.currentUser!.email;
    }
  }

  userImage() {
    if (firebaseAuth.currentUser!.photoURL != null) {
      return firebaseAuth.currentUser!.photoURL;
    }
  }
}
