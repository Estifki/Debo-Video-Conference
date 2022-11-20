import 'package:debo_01/network_helper/meeting_list.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class JoinCreateMeeting {
  static joinMeeting({
    required String serverUrl,
    required String subjectText,
    required String roomName,
    required String userName,
    required String userEmail,
    required bool audioMute,
    required bool videoMute,
    required bool areSecurityOptionsEnabled,
    required bool isAddPeopleEnabled,
    required bool isAndroidScreensharingEnabled,
    required bool isAudioFocusDisabled,
    required bool isWelcomePageEnabled,
    required bool isRecordingEnabled,
    required bool isChatEnabled,
    required bool isInviteEnabled,
    required bool isMeetingNameEnabled,
    required bool isKickoutEnabled,
    required bool isLobbyModeEnabled,
  }) async {
    try {
      var options = JitsiMeetingOptions(
        serverUrl: serverUrl,
        subject: subjectText,
        roomNameOrUrl: roomName,
        isAudioMuted: audioMute,
        isVideoMuted: videoMute,
        userDisplayName: userName,
        userEmail: userEmail,
        featureFlags: {
          FeatureFlag.areSecurityOptionsEnabled: areSecurityOptionsEnabled,
          FeatureFlag.isAddPeopleEnabled: isAddPeopleEnabled,
          FeatureFlag.isAndroidScreensharingEnabled:
              isAndroidScreensharingEnabled,
          FeatureFlag.isAudioFocusDisabled: isAudioFocusDisabled,
          FeatureFlag.isWelcomePageEnabled: isWelcomePageEnabled,
          FeatureFlag.isRecordingEnabled: isRecordingEnabled,
          FeatureFlag.isChatEnabled: isChatEnabled,
          FeatureFlag.isInviteEnabled: isInviteEnabled,
          FeatureFlag.isMeetingNameEnabled: isMeetingNameEnabled,
          FeatureFlag.isKickoutEnabled: isKickoutEnabled,
          FeatureFlag.isLobbyModeEnabled: isLobbyModeEnabled,
        },
      );

      await JitsiMeetWrapper.joinMeeting(
        options: options,
        listener: JitsiMeetingListener(),
      ).then((_) {
        MeetingList().addMeetingListToFirestore(
            serverUrl: serverUrl,
            roomName: roomName,
            userName: userName,
            subject: subjectText);
      });
    } catch (e) {
      rethrow;
    }
  }
}
