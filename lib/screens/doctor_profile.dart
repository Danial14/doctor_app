import 'dart:io';
import 'dart:typed_data';

import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:image_picker/image_picker.dart';

import '../widgets/profile_input.dart';

class DoctorProfile extends StatefulWidget {
  late String _email;
  DoctorProfile(String email){
    this._email = email;
  }
  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> implements ProvideFile{
  late Future<Map<String, dynamic>?> _dataFuture;
  String _profilePicture = "";
  String _userName = "Full name";
  String _fatherName = "Father name";
  String _registrationNo = "Registration No";
  String _registrationType = "Registration type";
  String _cnicNo = "CNIC No";
  String _licenseIssueDate = "License issue date";
  String _licenseValidUpto = "License valid upto";
  String _status = "Status";
  List<dynamic> _specializations = ["Specialization 1",
    "Specialization 2",
    "Specialization 3",
    "Specialization 4",
    "Specialization 5",
    "Specialization 6",
    "Specialization 7",
    "Specialization 8",
    "Specialization 9",
    "Specialization 10"
  ];
  final Map<String, dynamic> data = {};
  String _presentAddress = "Present address";
  String _permanentAddress = "Permanent address";
  File? profilePicController;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController registrationNoController = TextEditingController();
  final TextEditingController registrationTypeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController licenseIssueDateController = TextEditingController();
  final TextEditingController licenseValidityController = TextEditingController();
  final TextEditingController presentAddressController = TextEditingController();
  final TextEditingController permanentAddressController = TextEditingController();
  final TextEditingController specializationOneController = TextEditingController();
  final TextEditingController specializationTwoController = TextEditingController();
  final TextEditingController specializationThreeController = TextEditingController();
  final TextEditingController specializationFourController = TextEditingController();
  final TextEditingController specializationFiveController = TextEditingController();
  final TextEditingController specializationSixController = TextEditingController();
  final TextEditingController specializationSevenController = TextEditingController();
  final TextEditingController specializationEightController = TextEditingController();
  final TextEditingController specializationNineController = TextEditingController();
  final TextEditingController specializationTenController = TextEditingController();

  var _formState = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    _dataFuture = FirebaseDatabase.getInstance.fetchDoctorData(widget._email);
    super.initState();
  }
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
                        image: AssetImage("assets/images/doctor_profile_bg.png"
                        ),
                        fit: BoxFit.cover
                    )
                ),
                child: FutureBuilder<Map<String, dynamic>?>(
                  builder: (ctx, snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data != null){
                        _bindData(snapshot.data!);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              title: const Text("Profile",
                                  style: TextStyle(fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 20,),
                            Container(width: screenSize.width, alignment: Alignment.center,
                              child: const Text("Setup your profile", style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            const SizedBox(height: 10,),
                            Container(width: screenSize.width, alignment: Alignment.center,
                              child: badge.Badge(
                                badgeStyle: badge.BadgeStyle(
                                    badgeColor: const Color(0xff677294).withOpacity(0.8)
                                ),
                                badgeContent: const Icon(Icons.camera_alt_rounded, color: Colors.white,),
                                child: ProfilePicture(_profilePicture , this),
                                position: badge.BadgePosition.bottomEnd(bottom: 18),
                              ),
                            ),
                            const SizedBox(height: 25,),
                           const Padding(padding: EdgeInsets.only(left: 15),child: Text("Basic Info", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
                            Expanded(
                              child: Form(
                                key: _formState,
                                child: Container(
                                  width: screenSize.width,
                                  //height: 300,
                                  child: ListView(children: [
                                    ProfileInput(_userName, TextInputType.text, userNameController),
                                    ProfileInput(_fatherName, TextInputType.text, fatherNameController),
                                    ProfileInput(_registrationNo, TextInputType.text, registrationNoController),
                                    ProfileInput(_registrationType, TextInputType.text, registrationTypeController),
                                    ProfileInput(_status, TextInputType.text, statusController),
                                    ProfileInput(_licenseIssueDate, TextInputType.datetime, licenseIssueDateController),
                                    ProfileInput(_licenseValidUpto, TextInputType.datetime, licenseValidityController),
                                    ProfileInput(_cnicNo, TextInputType.text, cnicController),
                                    ProfileInput(_presentAddress, TextInputType.text, presentAddressController),
                                    ProfileInput(_permanentAddress, TextInputType.text, permanentAddressController),
                                    ProfileInput(_specializations[0], TextInputType.text, specializationOneController),
                                    ProfileInput(_specializations[1], TextInputType.text, specializationTwoController),
                                    ProfileInput(_specializations[2], TextInputType.text, specializationThreeController),
                                    ProfileInput(_specializations[3], TextInputType.text, specializationFourController),
                                    ProfileInput(_specializations[4], TextInputType.text, specializationFiveController),
                                    ProfileInput(_specializations[5], TextInputType.text, specializationSixController),
                                    ProfileInput(_specializations[6], TextInputType.text, specializationSevenController),
                                    ProfileInput(_specializations[7], TextInputType.text, specializationEightController),
                                    ProfileInput(_specializations[8], TextInputType.text, specializationNineController),
                                    ProfileInput(_specializations[9], TextInputType.text, specializationTenController),
                                  ]
                                  ),
                                ),
                              ),
                            ),
                           // SizedBox(height: 5,),
                            Container(
                              alignment: Alignment.center,
                              width: screenSize.width,
                              child: ElevatedButton(onPressed: () async{
                                _formState.currentState!.save();
                                print("user name from doctor : ${userNameController.text}");
                                data["username"] = userNameController.text == "" ? _userName : userNameController.text;
                                data["father name"] = fatherNameController.text == "" ? _fatherName : fatherNameController.text;
                                data["cnicNo"] = cnicController.text == "" ? _cnicNo : cnicController.text;
                                data["registrationNo"] = registrationNoController.text == "" ? _registrationNo : registrationNoController.text;
                                data["registration type"] = registrationTypeController.text == "" ? _registrationType : registrationTypeController.text;
                                data["status"] = statusController.text == "" ? _status : statusController.text;
                                data["license issue date"] = licenseIssueDateController.text == "" ? _licenseIssueDate : licenseIssueDateController.text;
                                data["license validity"] = licenseValidityController.text == "" ? _licenseValidUpto : licenseValidityController.text;
                                data["present address"] = presentAddressController.text == "" ? _presentAddress : presentAddressController.text;
                                data["permanent address"] = permanentAddressController.text == "" ? _permanentAddress : permanentAddressController.text;
                                data["specialization"] = [
                                  specializationOneController.text == "" ? _specializations[0] : specializationOneController.text,
                                  specializationTwoController.text == "" ? _specializations[1] : specializationTwoController.text,
                                  specializationThreeController.text == "" ? _specializations[2] : specializationThreeController.text,
                                  specializationFourController.text == "" ? _specializations[3] : specializationFourController.text,
                                  specializationFiveController.text == "" ? _specializations[4] : specializationFiveController.text,
                                  specializationSixController.text == "" ? _specializations[5] : specializationSixController.text,
                                  specializationSevenController.text == "" ? _specializations[6] : specializationSevenController.text,
                                  specializationEightController.text == "" ? _specializations[7] : specializationEightController.text,
                                  specializationNineController.text == "" ? _specializations[8] : specializationNineController.text,
                                  specializationTenController.text == "" ? _specializations[9] : specializationTenController.text,
                                ];
                                print("data : ${data}");
                                await FirebaseDatabase.getInstance.updateDoctorProfile(data, widget._email, profilePicController);
                              }, child: const Text("Submit")),
                            )
                          ],
                        );
                      }
                    }
                    print("didnt recieve data");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  future: _dataFuture,
                ),
              ),
            )
        ));
  }
  void _bindData(Map<String, dynamic> data){
    _userName = data["username"];
    _registrationNo = data["registrationNo"];
    if(data.containsKey("profilepic")){
      if(data["profilepic"] == null){
        data["profilepic"] = "";
      }
      _profilePicture = data["profilepic"];
      print("pro : $_profilePicture");
    }
    if(data.containsKey("specialization")){
      _specializations = data["specialization"];
    }
    if(data.containsKey("status")){
      _status = data["status"];
    }
    if(data.containsKey("cnicNo")){
      _cnicNo = data["cnicNo"];
    }
    if(data.containsKey("license issue date")){
      _licenseIssueDate = data["license issue date"];
    }
    if(data.containsKey("license validity")){
      _licenseValidUpto = data["license validity"];
    }
    if(data.containsKey("father name")){
      _fatherName = data["father name"];
    }
    if(data.containsKey("present address")){
      _presentAddress = data["present address"];
    }
    if(data.containsKey("permanent address")){
      _permanentAddress = data["permanent address"];
    }
    if(data.containsKey("registration type")){
      _registrationType = data["registration type"];
    }
  }

  @override
  void provideFile(File image) {
    print("image received");
    profilePicController = image;
  }
}
abstract interface class ProvideFile{
  void provideFile(File image);
}