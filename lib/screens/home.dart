import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../const/colors.dart';
import '../network_helper/start_meeting.dart';
import '../widgets/meeting_card.dart';
import '../widgets/switch.dart';
import '../widgets/textfeild.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final serverText = TextEditingController();
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  final userName = TextEditingController();
  final userEmail = TextEditingController();
  bool isAudioMuted = true;
  bool isVideoMuted = false;
  bool areSecurityOptionsEnabled = true;
  bool isAddPeopleEnabled = true;
  bool isAndroidScreensharingEnabled = true;
  bool isAudioFocusDisabled = true;
  bool isWelcomePageEnabled = false;
  bool isRecordingEnabled = true;
  bool isChatEnabled = true;
  bool isInviteEnabled = true;
  bool isMeetingNameEnabled = true;
  bool isKickoutEnabled = true;
  bool isMeetingPasswordEnabled = false;
  bool isLobbyModeEnabled = false;
  String? serverUrl;

  @override
  void initState() {
    if (Hive.box("ServerUrl").get(0).toString().isEmpty ||
        Hive.box("ServerUrl").get(0).toString() == "null") {
      serverUrl =
          Hive.box("ServerUrl").put(0, "https://meet.jit.si").toString();
    }
    serverUrl = Hive.box("ServerUrl").get(0).toString();
    super.initState();
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: 10, left: 10, top: screenSize.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => setting(context),
                      child: const Icon(Icons.settings,
                          size: 28, color: Colors.white),
                    ),
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
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => createMeeting(context),
                            child: MeetingCard(
                              labelText: "New meeting",
                              color: const Color.fromARGB(255, 127, 93, 131),
                              icon: const Icon(
                                Icons.video_call_rounded,
                                size: 30,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => joinMeeting(context),
                            child: MeetingCard(
                              labelText: "Join meeting",
                              color: const Color.fromARGB(255, 58, 101, 172),
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setting(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: CustomTextField(
                            labelText: "ServerUrl",
                            controller: serverText,
                            hintText: serverUrl.toString().isEmpty
                                ? ""
                                : serverUrl.toString(),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Hive.box("ServerUrl")
                                .put(0, serverText.text)
                                .toString();
                            serverUrl = Hive.box("ServerUrl").get(0).toString();

                            setState(() {});
                          },
                          icon: const Icon(Icons.done_rounded))
                    ],
                  ),
                  BottomSheetSwitch(
                    label: "Security Options Enabled",
                    switchValue: areSecurityOptionsEnabled,
                    valueChanged: (_) {
                      areSecurityOptionsEnabled = !areSecurityOptionsEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Add People Enabled",
                    switchValue: isAddPeopleEnabled,
                    valueChanged: (_) {
                      isAddPeopleEnabled = !isAddPeopleEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Android Screen-sharing Enabled",
                    switchValue: isAndroidScreensharingEnabled,
                    valueChanged: (_) {
                      isAndroidScreensharingEnabled =
                          !isAndroidScreensharingEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Audio Focus Disabled",
                    switchValue: isAudioFocusDisabled,
                    valueChanged: (_) {
                      isAudioFocusDisabled = !isAudioFocusDisabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Welcome-Page Enabled",
                    switchValue: isWelcomePageEnabled,
                    valueChanged: (_) {
                      isWelcomePageEnabled = !isWelcomePageEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Chat Enabled",
                    switchValue: isChatEnabled,
                    valueChanged: (_) {
                      isChatEnabled = !isChatEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Invite Enabled ",
                    switchValue: isInviteEnabled,
                    valueChanged: (_) {
                      isInviteEnabled = !isInviteEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Kickout Enabled",
                    switchValue: isKickoutEnabled,
                    valueChanged: (_) {
                      isKickoutEnabled = !isKickoutEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Lobby-Mode Enabled",
                    switchValue: isLobbyModeEnabled,
                    valueChanged: (_) {
                      isLobbyModeEnabled = !isLobbyModeEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Meeting-Name Enabled",
                    switchValue: isMeetingNameEnabled,
                    valueChanged: (_) {
                      isMeetingNameEnabled = !isMeetingNameEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Meeting Password Enabled",
                    switchValue: isMeetingPasswordEnabled,
                    valueChanged: (_) {
                      isMeetingPasswordEnabled = !isMeetingPasswordEnabled;
                    },
                  ),
                  const Divider(),
                  BottomSheetSwitch(
                    label: "Recording Enabled",
                    switchValue: isRecordingEnabled,
                    valueChanged: (_) {
                      isRecordingEnabled = !isRecordingEnabled;
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  joinMeeting(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: SizedBox(
              height: 370,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Join Meeting",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      CustomTextField(
                        labelText: "Room name",
                        controller: roomText,
                      ),
                      // CustomTextField(
                      //     labelText: "Subject", controller: subjectText),
                      CustomTextField(
                        labelText: "Username",
                        controller: userName,
                      ),
                      // CustomTextField(
                      //     labelText: "Email", controller: userEmailText),
                      BottomSheetSwitch(
                        label: "Audio Muted",
                        switchValue: isAudioMuted,
                        valueChanged: (_) {
                          setState(() {
                            isAudioMuted = !isAudioMuted;
                          });
                        },
                      ),

                      BottomSheetSwitch(
                        label: "Video Muted",
                        switchValue: isVideoMuted,
                        valueChanged: (_) {
                          setState(() {
                            isVideoMuted = !isVideoMuted;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 46.0,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            if (roomText.text == "" || userName.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Empty Field Detected!"),
                                ),
                              );
                            } else if (serverUrl == "" ||
                                serverUrl == "null" ||
                                !serverUrl!.startsWith("https")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text("Invalid Server URL!"),
                                  action: SnackBarAction(
                                      label: "Make Default Now",
                                      onPressed: () {
                                        Hive.box("ServerUrl")
                                            .put(0, "https://meet.jit.si")
                                            .toString();
                                        serverUrl = Hive.box("ServerUrl")
                                            .get(0)
                                            .toString();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            width: 120,
                                            backgroundColor: Colors.green,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "Updated",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        setState(() {});
                                      }),
                                ),
                              );
                            } else {
                              JoinCreateMeeting.joinMeeting(
                                serverUrl: serverUrl.toString(),
                                roomName: roomText.text,
                                subjectText: subjectText.text,
                                userName: userName.text,
                                userEmail: userEmail.text,
                                audioMute: isAudioMuted,
                                videoMute: isVideoMuted,
                                isChatEnabled: isChatEnabled,
                                isInviteEnabled: isInviteEnabled,
                                isRecordingEnabled: isRecordingEnabled,
                                isAddPeopleEnabled: isAddPeopleEnabled,
                                areSecurityOptionsEnabled:
                                    areSecurityOptionsEnabled,
                                isAndroidScreensharingEnabled:
                                    isAndroidScreensharingEnabled,
                                isLobbyModeEnabled: isLobbyModeEnabled,
                                isWelcomePageEnabled: isWelcomePageEnabled,
                                isAudioFocusDisabled: isAudioFocusDisabled,
                                isMeetingNameEnabled: isMeetingNameEnabled,
                                isKickoutEnabled: isKickoutEnabled,
                              );
                            }
                          },
                          child: const Text(
                            "Join Meeting",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => customBlueColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  createMeeting(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: SizedBox(
              height: 500,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Create Meeting",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      CustomTextField(
                        labelText: "Room name",
                        controller: roomText,
                      ),
                      CustomTextField(
                        labelText: "Subject",
                        controller: subjectText,
                      ),
                      CustomTextField(
                        labelText: "Username",
                        controller: userName,
                      ),
                      CustomTextField(
                        labelText: "Email(optional)",
                        controller: userEmail,
                      ),
                      BottomSheetSwitch(
                        label: "Audio Muted",
                        switchValue: isAudioMuted,
                        valueChanged: (_) {
                          setState(() {
                            isAudioMuted = !isAudioMuted;
                          });
                        },
                      ),
                      BottomSheetSwitch(
                        label: "Video Muted",
                        switchValue: isVideoMuted,
                        valueChanged: (_) {
                          setState(() {
                            isVideoMuted = !isVideoMuted;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 46.0,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            if (roomText.text == "" || userName.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Empty Field Detected!"),
                                ),
                              );
                            } else if (serverUrl == "" ||
                                serverUrl == "null" ||
                                !serverUrl!.startsWith("https")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text("Invalid Server URL!"),
                                  action: SnackBarAction(
                                      label: "Make Default Now",
                                      onPressed: () {
                                        Hive.box("ServerUrl")
                                            .put(0, "https://meet.jit.si")
                                            .toString();
                                        serverUrl = Hive.box("ServerUrl")
                                            .get(0)
                                            .toString();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            width: 120,
                                            backgroundColor: Colors.green,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "Updated",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        setState(() {});
                                      }),
                                ),
                              );
                            } else {
                              JoinCreateMeeting.joinMeeting(
                                serverUrl: serverUrl.toString(),
                                roomName: roomText.text,
                                subjectText: subjectText.text,
                                userName: userName.text,
                                userEmail: userEmail.text,
                                audioMute: isAudioMuted,
                                videoMute: isVideoMuted,
                                isChatEnabled: isChatEnabled,
                                isInviteEnabled: isInviteEnabled,
                                isRecordingEnabled: isRecordingEnabled,
                                isAddPeopleEnabled: isAddPeopleEnabled,
                                areSecurityOptionsEnabled:
                                    areSecurityOptionsEnabled,
                                isAndroidScreensharingEnabled:
                                    isAndroidScreensharingEnabled,
                                isLobbyModeEnabled: isLobbyModeEnabled,
                                isWelcomePageEnabled: isWelcomePageEnabled,
                                isAudioFocusDisabled: isAudioFocusDisabled,
                                isMeetingNameEnabled: isMeetingNameEnabled,
                                isKickoutEnabled: isKickoutEnabled,
                              );
                            }
                          },
                          child: const Text(
                            "Create Meeting",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => customBlueColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
