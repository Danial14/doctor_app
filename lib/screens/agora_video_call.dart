import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/rtc_buttons.dart';
import 'package:cliniconline/constants/myconstants.dart';
import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/screens/doctor_profile.dart';
import 'package:cliniconline/screens/signup_screen.dart';
import 'package:cliniconline/screens/tabs.dart';
import 'package:cliniconline/widgets/chat.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AgoraVideoCall extends StatefulWidget {
  late String _channelName;
  late String _patientEmail;
  late bool _isDoctor;
  AgoraVideoCall(String channelName, String patientEmail, bool isDoctor){
    this._channelName = channelName;
    this._patientEmail = patientEmail;
    this._isDoctor = isDoctor;
  }
  @override
  State<AgoraVideoCall> createState() => _AgoraVideoCallState();
}

class _AgoraVideoCallState extends State<AgoraVideoCall> {
  // Instantiate the client
  AgoraClient? client;

// Initialize the Agora Engine

  void initAgora() async {
    await client!.initialize();
  }

// Build your layout
  @override
  Widget build(BuildContext context) {
    if(client == null){
      client = AgoraClient(
          agoraConnectionData: AgoraConnectionData(
            appId: MyConstants.appId,
            channelName: widget._channelName,
          ),
          enabledPermission: [Permission.camera, Permission.audio],
          agoraEventHandlers: AgoraRtcEventHandlers(
            onUserOffline: (connection, uid, userOfflineReasonType){
              print("offline user");
              print("user ${uid} has left the channel");
              _leaveChannel();
            },
              onLeaveChannel: (connection, stats){
                print("user left channel ${context == null}");
                _navigateToOtherRoute();
              }
          )
      );
      initAgora();
    }
    return Scaffold(
        body: SafeArea(
          child: Stack(
                children: [
                  AgoraVideoViewer(client: client!,
                  layoutType: Layout.oneToOne,
                  ),
                  AgoraVideoButtons(client: client!),
                  Positioned(child: Chat(widget._channelName, widget._patientEmail, widget._isDoctor),
                  top: MediaQuery.of(context).size.height * 0.4,
                    bottom: MediaQuery.of(context).size.height * 0.2,
                  )
                ],
              )
        ),
    );
  }
  Future<void> _leaveChannel() async{
    await client!.engine.leaveChannel();
    _navigateToOtherRoute();
  }
  void _navigateToOtherRoute() async{
    if(widget._isDoctor){
      Navigator.of(MyApp.navigatorKey.currentContext!).pushReplacement(MaterialPageRoute(builder: (ctx){
        return DoctorProfile(widget._channelName);
      }));
    }
    else{
      Navigator.of(MyApp.navigatorKey.currentContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
        return TabsScreen(widget._patientEmail);
      }), ModalRoute.withName("/"));
    }
  }
}
