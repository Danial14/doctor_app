import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/screens/agora_video_call.dart';
import 'package:cliniconline/widgets/favouriate_heart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;
class FindDoctors extends StatefulWidget {
  late String _email;
  FindDoctors(String email){
    print("Find doctors : ${email}");
    this._email = email;
  }

  @override
  State<FindDoctors> createState() => _FindDoctorsState();
}

class _FindDoctorsState extends State<FindDoctors> {
  String _doctorMode = "default mode";
  List? _favouriateDoctors;
  var _searchController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? _searchStream;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Splash.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 20,),
                  Container(width: screenSize.width,
                    height: screenSize.height * 0.2,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.arrow_back_ios,size: 10),
                            ),
                          ),
                          title: const Text("Find Doctors",
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenSize.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.16),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: const Offset(2,7)
                                )
                              ]
                          ),
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: InkWell(
                                child: Icon(Icons.search,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                onTap: () async{
                                  print("searching ${_searchController.text}");
                                  Stream<QuerySnapshot<Map<String, dynamic>>>? stream = await FirebaseDatabase.getInstance.doctorFilterSearch(_searchController.text);
                                  if(stream != null){
                                    _doctorMode = "search";
                                    _searchStream = stream;
                                    setState(() {

                                    });
                                  }
                                },
                              ),
                              hintText: "Search Live Doctors",
                              suffixIcon: InkWell(
                                child: Icon(Icons.close,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                onTap: (){
                                  _searchController.text = "";
                                  _doctorMode = "default mode";
                                  _searchStream = null;
                                  setState(() {

                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(flex: 1,
                    child: Container(
                      width: screenSize.width * 0.9,
                      height: screenSize.height * 0.55,
                      child: StreamBuilder(
                        stream: _doctorMode == "default mode"? FirebaseDatabase.getInstance.fetchLiveDoctors() : _searchStream!,
                        builder: (ctx, snapshots){
                          if(snapshots.connectionState == ConnectionState.waiting || !snapshots.hasData){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          //print("live data ${snapshots.data!.docs[0].data()}");
                          List<QueryDocumentSnapshot<Map<String, dynamic>>> liveDoctors = snapshots.data!.docs;

                          return ListView.builder(itemBuilder: (ctx, position){
                            Map<String, dynamic> doctorData = liveDoctors[position].data();
                            return Container(
                                width: screenSize.width * 0.9,
                                height: 230,
                                child: Card(
                                    elevation: 6,
                                    child: Padding(child: Column(
                                      children: <Widget>[
                                        Row(
                                            children: <Widget>[
                                              badges.Badge(child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      image: DecorationImage(
                                                          image: CachedNetworkImageProvider(doctorData["profilepic"]),
                                                          fit: BoxFit.cover
                                                      )
                                                  ),
                                                  width: 100,
                                                  height: 120,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                  )
                                              ),
                                                  badgeContent: doctorData["live_status"] == "live" ? Container(
                                                      width: 60,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                      ),
                                                      child: Row(
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                                radius: 3,
                                                                backgroundColor: Colors.white
                                                            ),
                                                            SizedBox(width: 2),
                                                            Text("Live", style: TextStyle(
                                                                color: Colors.white
                                                            ))
                                                          ]
                                                      )
                                                  ) : Container(),
                                                  badgeStyle: badges.BadgeStyle(
                                                      shape: badges.BadgeShape.square,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  position: badges.BadgePosition.topStart(start: -1, top: -1)
                                              ),
                                              SizedBox(width: 5),
                                              Container(child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Dr.Shruti Kedia", style: TextStyle(fontSize: 18)),
                                                    SizedBox(height: 2),
                                                    Text("Tooth Dentist"),
                                                    SizedBox(height: 2),
                                                    Text("7 years of experience"),
                                                    SizedBox(height: 8),
                                                    Expanded(
                                                      child: Row(
                                                        children: <Widget>[
                                                          CircleAvatar(radius: 3, backgroundColor: Color(0xff0EBE7F),),
                                                          SizedBox(width: 3),
                                                          Text("89%"),
                                                          SizedBox(width: 10),
                                                          CircleAvatar(radius: 3, backgroundColor: Color(0xff0EBE7F),),
                                                          SizedBox(width: 3),
                                                          Text("69 patient stories"),
                                                        ],
                                                      ),
                                                    )
                                                  ]
                                              ),
                                                  width: 170,
                                                  height: 120
                                              ),
                                              Container(
                                                  height: 120,
                                                  alignment: Alignment.topLeft,
                                                  child: /*InkWell(onTap: (){
                                                    print("favouriates tap");
                                                  },
                                                      child: _favouriateDoctors != null && _favouriateDoctors!.contains(snapshots.data!.docs[position])? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border)
                                                  )*/
                                                FavouriateHeart(_favouriateDoctors != null && _favouriateDoctors!.contains(snapshots.data!.docs[position].reference), _updateFavouriateDoctorList, snapshots.data!.docs[position].reference)
                                              )
                                            ]
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            Expanded(child: Container(child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Next Available"),
                                                SizedBox(height: 2,),
                                                Text("12:00 PM tomorrow")
                                              ],
                                            )), flex: 1),
                                            Expanded(flex: 1,child: Container(
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.only(right: 5),
                                              child: InkWell(
                                                onTap: () async{
                                                  if(doctorData["live_status"] == "live"){
                                                    // start video call
                                                    print("video call");
                                                    _sendPushNotification(doctorData["email"], doctorData["username"], doctorData["deviceToken"]);
                                                  }
                                                  else{
                                                    // book appointment


                                                  }
                                                },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(0xff0EBE7F),
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      width: 120,
                                                      height: 40,
                                                      child: Center(
                                                          child: Text(doctorData["live_status"] == "live" ? "Call" : "Book now")
                                                      )
                                                  )
                                              ),
                                            ))
                                          ],
                                        )
                                        /*InkWell(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xff0EBE7F),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              width: 150,
                                              height: 50,
                                              child: Center(
                                                  child: Text("Book Now $position")
                                              )
                                          )
                                      )*/
                                      ],
                                    ), padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20))));
                          },
                            itemCount: liveDoctors.length,
                          );
                        },
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    _fetchFavouriateDoctors();
    print("outside fetching favouriate doctor");
    super.initState();
  }
  void _fetchFavouriateDoctors() async{
    _favouriateDoctors = await FirebaseDatabase.getInstance.getFavouriateDoctorsList(widget._email);
    if(_favouriateDoctors == null){
      print("No favouriate doctor found");
    }

    setState(() {
      print("favouriate doctor fetching done");
    });
  }
  void _updateFavouriateDoctorList(bool favouriateStatus, DocumentReference data) async{
    if(favouriateStatus){
      if(_favouriateDoctors == null){
        _favouriateDoctors = [];
      }
      _favouriateDoctors!.add(data);
      await FirebaseDatabase.getInstance.updateFavouriateDoctorLive(widget._email, _favouriateDoctors!);
      print("fav item added");
    }
    else{
      if(_favouriateDoctors != null) {
        _favouriateDoctors!.remove(data);
        await FirebaseDatabase.getInstance.updateFavouriateDoctorLive(widget._email, _favouriateDoctors!);
      }
      print("fav item removed");
    }
  }
  Future<void> _sendPushNotification(String doctorEmail, String userName, String deviceToken) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=AAAAadC_SQc:APA91bGO5EWi4j8XKzNgIPOEb7iFVC0XO7Wmu4pWuBpvzQI5NeGSEQLBnMZQS8mq78Tavo4qNmvRmg4CR8HdJPXYSBRBz2HrjRKDKMDw6hAP-oBE2FxLGjgYO3_zcQF8zyXdXxQrmSj0',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': {
                "doctorEmail" : doctorEmail,
                "message" : "Please recieve the call",
                "username" : userName,
                "patientEmail" : widget._email
              },
              'title': 'Call from patient',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': deviceToken,
          },
        ),
      );
      print("fcm response code : ${response.statusCode}");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
        return AgoraVideoCall(doctorEmail, widget._email, false);
      }));
    } catch (e) {
      print("fcm error");
      print(e);
    }
  }
}