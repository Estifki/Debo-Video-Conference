import 'package:debo_01/screens/login.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main_screen.dart';

class GoogleAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'profile',
    'email',
  ]);
  authCheck() {
    return StreamBuilder(
      stream: firebaseAuth.authStateChanges(),
      builder: (BuildContext ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapShot.hasData) {
          return const MainScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }

  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount? userSignIn = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await userSignIn!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await firestore.collection("Users").doc(user.uid).set({
            "UserName": user.displayName,
            "Phone": user.phoneNumber,
            "Email": user.email,
            "Photo": user.photoURL,
          });
        }
      }
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  signOut() async {
    try {
      await firebaseAuth.signOut().then((_) {
        googleSignIn.disconnect();
      });
    } catch (e) {
      rethrow;
    }
  }
}
