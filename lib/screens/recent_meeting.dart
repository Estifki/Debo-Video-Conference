import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../network_helper/meeting_list.dart';
import '../const/colors.dart';

class RecentMeetings extends StatelessWidget {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        child: StreamBuilder<QuerySnapshot>(
            stream: MeetingList().getMeetingLists,
            builder: (BuildContext context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapShot.hasData && snapShot.data!.docs.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: ListView.builder(
                        itemCount: snapShot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Room name: ${snapShot.data!.docs[index]['roomName']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "  Date: ${snapShot.data!.docs[index]['date']}",
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Divider(
                                  color: Colors.white54,
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                } else if (snapShot.hasError) {
                  return const Center(
                    child: Text("Unknown Error Occured",
                        style: TextStyle(color: Colors.white)),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "No Recent Meetings.",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Create/Join meeting and it appers here",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
