import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MeetingList {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get getMeetingLists => firestore
      .collection("Users")
      .doc(firebaseAuth.currentUser!.uid)
      .collection("Meetings")
      .snapshots();

  addMeetingListToFirestore({
    required String serverUrl,
    required String roomName,
    required String userName,
    required String subject,
  }) async {
    await firestore
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Meetings")
        .add({
      "serverUrl": serverUrl,
      "roomName": roomName,
      "userName": userName,
      "subject": subject,
      "date": DateTime.now().toString().substring(0, 10),
    });
  }
}
