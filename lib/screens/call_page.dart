import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../constants/myconstants.dart';

class CallPage extends StatelessWidget {

  CallPage(String userId, String userName, {super.key}){
    print("call page");
    this.userId = userId.replaceFirst("@", "_");
    this.userName = userName;
  }
  final String callID = "1";
  late String userId;
  late String userName;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: 0, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: MyConstants.appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: this.userId,
        userName: this.userName,
        callID: callID,
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
      ),
    );
  }
}