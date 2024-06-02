import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cliniconline/providers/favouriate_doctor_provider.dart';
import 'package:cliniconline/screens/agora_video_call.dart';
import 'package:cliniconline/screens/allrecord_screen.dart';
import 'package:cliniconline/screens/diagonstics_tests_screen.dart';
import 'package:cliniconline/screens/doctor_profile.dart';
import 'package:cliniconline/screens/doctor_signup_screen.dart';
import 'package:cliniconline/screens/enable_location_screen.dart';
import 'package:cliniconline/screens/favouriate_doctor.dart';
import 'package:cliniconline/screens/finddoctors.dart';
import 'package:cliniconline/screens/login.dart';
import 'package:cliniconline/screens/medicalrecord_screen.dart';
import 'package:cliniconline/screens/medicine_orders_screen.dart';
import 'package:cliniconline/screens/medicine_orders_screen2.dart';
import 'package:cliniconline/screens/option_screen.dart';
import 'package:cliniconline/screens/patient_details_screen.dart';
import 'package:cliniconline/screens/patient_profile.dart';
import 'package:cliniconline/screens/phonelogin.dart';
import 'package:cliniconline/screens/signup_screen.dart';
import 'package:cliniconline/screens/splash_screen.dart';
import 'package:cliniconline/widgets/new_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  AwesomeNotifications().initialize(null, <NotificationChannel>[
    NotificationChannel(channelKey: "call_channel", channelName: "Call channel", channelDescription: "Channel of calling",
    defaultColor: Colors.redAccent,
      ledColor: Colors.white,
      locked: true,
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      defaultRingtoneType: DefaultRingtoneType.Ringtone
    )
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
  // This widget is the root of your application.

}
class _MyAppState extends State<MyApp>{
  //dynamic incomingSDPOffer;
  /*final String selfCallerID = Random().nextInt(999999).toString().padLeft(6, '0');
  final String websocketUrl = "WEB_SOCKET_SERVER_URL";*/
  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.onMessage.listen((event) {
      var notificationBodyData = jsonDecode(event.notification!.body!);
      print("Notification body data : ${notificationBodyData}");
      String? notificationTitle = event.notification!.title;
      String? notificationBodyMessage = notificationBodyData["message"];
      AwesomeNotifications awesomeNotifications = AwesomeNotifications();
      awesomeNotifications.createNotification(content: NotificationContent(id: 12,
          channelKey: "call_channel",
        category: NotificationCategory.Call,
        color: Colors.white,
        title: notificationTitle,
        body: notificationBodyMessage,
        autoDismissible: false,
        fullScreenIntent: true,
        wakeUpScreen: true,
        backgroundColor: Colors.orange,
      ),
      actionButtons: <NotificationActionButton>[
        NotificationActionButton(key: "accept", label: "Accept", autoDismissible: true),
        NotificationActionButton(key: "reject", label: "Reject", autoDismissible: true)
      ]
      );
      awesomeNotifications.setListeners(onActionReceivedMethod: (actionReceived) async{
        if(actionReceived.buttonKeyPressed == "reject"){
          print("call rejected");
        }
        else if(actionReceived.buttonKeyPressed == "accept"){
          print("call accepted");
          print("${notificationBodyData["doctorEmail"]}");
          print("${notificationBodyData["username"]}");
          _goToCallPage(notificationBodyData["doctorEmail"], notificationBodyData["username"], notificationBodyData["patientEmail"]);
        }
      });
    });
    /*SignallingService.instance.init(
      websocketUrl: websocketUrl,
      selfCallerID: selfCallerID,
    );*/
    // listening for call
    /*SignallingService.instance.socket!.on("newCall", (data) {
      print("new call");
      incomingSDPOffer = data;
      AwesomeNotifications awesomeNotifications = AwesomeNotifications();
      awesomeNotifications.createNotification(content: NotificationContent(id: 12,
        channelKey: "call_channel",
        category: NotificationCategory.Call,
        color: Colors.white,
        title: "Call",
        body: "Please recieve call",
        autoDismissible: false,
        fullScreenIntent: true,
        wakeUpScreen: true,
        backgroundColor: Colors.orange,
      ),
          actionButtons: <NotificationActionButton>[
            NotificationActionButton(key: "accept", label: "Accept", autoDismissible: true),
            NotificationActionButton(key: "reject", label: "Reject", autoDismissible: true)
          ]
      );
      awesomeNotifications.setListeners(onActionReceivedMethod: (actionReceived) async{
        if(actionReceived.buttonKeyPressed == "reject"){
          print("call rejected");
        }
        else if(actionReceived.buttonKeyPressed == "accept"){
          print("call accepted");
          print("callerId : ${data["callerId"]}");
          print("calleeId : ${data["calleeId"]}");
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
            return CallScreen(offer: data, callerId: data["callerId"], calleeId: data["calleeId"]);
          }));
          //_goToCallPage(notificationBodyData["doctorEmail"], notificationBodyData["username"]);
        }
      });
    });*/
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx){
          return FavouriateDoctorProvider();
        })
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Clinic Online',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
  void _goToCallPage(String doctorEmail, String username, String patientEmail){
    print("gotoCallPage");
    print("notification email : ${doctorEmail}");
    print("notification username : ${username}");
    Navigator.of(MyApp.navigatorKey.currentContext!).pushReplacement(MaterialPageRoute(builder: (ctx){
      return AgoraVideoCall(doctorEmail, patientEmail, true);
    }));
  }
}

