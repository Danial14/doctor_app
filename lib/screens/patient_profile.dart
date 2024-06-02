import 'dart:io';

import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/screens/MyCheckBox.dart';
import 'package:cliniconline/screens/doctor_profile.dart';
import 'package:cliniconline/widgets/profile_input.dart';
import 'package:cliniconline/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

class PatientProfile extends StatefulWidget {
  late String _email;
  PatientProfile(String email){
    this._email = email;
  }
  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> implements ProvideFile{
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergyOneController = TextEditingController();
  final TextEditingController _allergyTwoController = TextEditingController();
  final TextEditingController _allergyThreeController = TextEditingController();
  final TextEditingController _allergyFourController = TextEditingController();
  final TextEditingController _allergyFiveController = TextEditingController();
  final TextEditingController _allergySixController = TextEditingController();
  final TextEditingController _allergySevenController = TextEditingController();
  final TextEditingController _allergyEightController = TextEditingController();
  final TextEditingController _allergyNineController = TextEditingController();
  final TextEditingController _allergyTenController = TextEditingController();
  final TextEditingController _allergyElevenController = TextEditingController();
  final TextEditingController _allergyTwelveController = TextEditingController();
  final List<String> _diseases = [
    "Diabetes",
    "Blood presssure",
    "Cholestrol",
    "Heart patient",
    "Tuberculosis",
    "Cancer",
    "Hepatitis A",
    "Hepatitis E",
    "Fever",
    "Hypertension",
    "Anxiety",
    "Migraine"
  ];
  File? profilePicController;
  List _fetchedDiseases = [];
  String _profilePicture = "";
  String _firstName = "First name";
  String _lastName = "Last name";
  String _dateOfBirth = "Date of birth";
  String _address = "Address";
  String _city = "City";
  String _province = "Province";
  String _postalCode = "Postal code";
  String _weight = "Weight";
  String _allergyOne = "Allergy no1";
  String _allergyTwo = "Allergy no2";
  String _allergyThree = "Allergy no3";
  String _allergyFour = "Allergy no4";
  String _allergyFive = "Allergy no5";
  String _allergySix = "Allergy no6";
  String _allergySeven = "Allergy no7";
  String _allergyEight = "Allergy no8";
  String _allergyNine = "Allergy no9";
  String _allergyTen = "Allergy no10";
  String _allergyEleven = "Allergy no11";
  String _allergyTwelve = "Allergy no12";
  var _formKey = GlobalKey<FormState>();

  late Future<Map<String, dynamic>?> _dataFuture;
  @override
  void initState() {
    // TODO: implement initState
    _dataFuture = FirebaseDatabase.getInstance.fetchPatientData(widget._email);
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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/patient_profile.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: FutureBuilder<Map<String, dynamic>?>(
                  future: _dataFuture,
                  builder: (ctx, snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data != null){
                        _bindData(snapshot.data!);
                        return Form(
                          key: _formKey,
                          child: Column(
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
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.arrow_back_ios,size: 10),
                                  ),
                                ),
                                title: Text("Profile",
                                    style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: 5,),
                              Container(width: screenSize.width, alignment: Alignment.center,
                                child: Text("Setup your profile", style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                              SizedBox(height: 10,),
                              Container(width: screenSize.width, alignment: Alignment.center,
                                child: badge.Badge(
                                  badgeStyle: badge.BadgeStyle(
                                      badgeColor: Color(0xff677294).withOpacity(0.8)
                                  ),
                                  badgeContent: Icon(Icons.camera_alt_rounded, color: Colors.white,),
                                  child: ProfilePicture(_profilePicture, this),
                                  position: badge.BadgePosition.bottomEnd(bottom: 18),
                                ),
                              ),
                              Container(
                                width: screenSize.width,
                                height: screenSize.height * 0.20,
                                child: ListView(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text("Basic Info",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      ProfileInput(_firstName, TextInputType.text, _firstNameController),
                                      ProfileInput(_lastName, TextInputType.text, _lastNameController),
                                      ProfileInput(_dateOfBirth, TextInputType.datetime, _dobController),
                                      ProfileInput(_address, TextInputType.text, _addressController),
                                      ProfileInput(_city, TextInputType.text, _cityController),
                                      ProfileInput(_province, TextInputType.text, _provinceController),
                                      ProfileInput(_postalCode, TextInputType.number, _postalCodeController),
                                      ProfileInput(_weight, TextInputType.text, _weightController),
                                    ]
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                  width: screenSize.width,
                                  height: screenSize.height * 0.20,
                                  child: ListView.builder(
                                    itemCount: _diseases.length,
                                    itemBuilder: (ctx, position){
                                      if(position == 0){
                                        return Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text("Diseases",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        );
                                      }
                                      else{
                                        return CustomCheckBox(_fetchedDiseases.isEmpty || !(_fetchedDiseases.contains(_diseases[position - 1])) ? false : true, _diseases[position - 1], _fetchedDiseases);
                                      }
                                    },
                                  )
                              ),
                              SizedBox(height: 5,),
                              Expanded(
                                child: Container(
                                  width: screenSize.width,
                                  //height: screenSize.height * 0.20,
                                  child: ListView(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text("Allergies",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        ProfileInput(_allergyOne, TextInputType.text, _allergyOneController),
                                        ProfileInput(_allergyTwo, TextInputType.text, _allergyTwoController),
                                        ProfileInput(_allergyThree, TextInputType.text, _allergyThreeController),
                                        ProfileInput(_allergyFour, TextInputType.text, _allergyFourController),
                                        ProfileInput(_allergyFive, TextInputType.text, _allergyFiveController),
                                        ProfileInput(_allergySix, TextInputType.text, _allergySixController),
                                        ProfileInput(_allergySeven, TextInputType.text, _allergySevenController),
                                        ProfileInput(_allergyEight, TextInputType.text, _allergyEightController),
                                        ProfileInput(_allergyNine, TextInputType.text, _allergyNineController),
                                        ProfileInput(_allergyTen, TextInputType.text, _allergyTenController),
                                        ProfileInput(_allergyEleven, TextInputType.text, _allergyElevenController),
                                        ProfileInput(_allergyTwelve, TextInputType.text, _allergyTwelveController),
                                      ]
                                  ),
                                ),
                              ),
                              Center(child: ElevatedButton(onPressed: (){
                                _formKey.currentState!.save();
                                Map<String, dynamic> data = {};
                                data["first name"] = _firstNameController.text == "" ? _firstName : _firstNameController.text;
                                data["lastname"] = _lastNameController.text == "" ? _lastName : _lastNameController.text;
                                data["city"] = _cityController.text == "" ? _city : _cityController.text;
                                data["province"] = _provinceController.text == "" ? _province : _provinceController.text;
                                data["postal code"] = _postalCodeController.text == "" ? _postalCode : _postalCodeController.text;
                                data["address"] = _addressController.text == "" ? _address : _addressController.text;
                                data["weight"] = _weightController.text == "" ? _weight : _weightController.text;
                                data["allergyOne"] = _allergyOneController.text == "" ? _allergyOne : _allergyOneController.text;
                                data["allergyTwo"] = _allergyTwoController.text == "" ? _allergyTwo : _allergyTwoController.text;
                                data["allergyThree"] = _allergyThreeController.text == "" ? _allergyThree : _allergyThreeController.text;
                                data["allergyFour"] = _allergyFourController.text == "" ? _allergyFour : _allergyFourController.text;
                                data["allergyFive"] = _allergyFiveController.text == "" ? _allergyFive : _allergyFiveController.text;
                                data["allergySix"] = _allergySixController.text == "" ? _allergySix : _allergySixController.text;
                                data["allergySeven"] = _allergySevenController.text == "" ? _allergySeven : _allergySevenController.text;
                                data["allergyEight"] = _allergyEightController.text == "" ? _allergyEight : _allergyEightController.text;
                                data["allergyNine"] = _allergyNineController.text == "" ? _allergyNine : _allergyNineController.text;
                                data["allergyTen"] = _allergyTenController.text == "" ? _allergyTen : _allergyTenController.text;
                                data["allergyEleven"] = _allergyElevenController.text == "" ? _allergyEleven : _allergyElevenController.text;
                                data["allergyTwelve"] = _allergyTwelveController.text == "" ? _allergyTwelve : _allergyTwelveController.text;
                                data["diseases"] = _fetchedDiseases;
                                FirebaseDatabase.getInstance.updatePatientProfile(data, widget._email, profilePicController);
                              }, child: Text("Submit")))
                            ],
                          ),
                        );
                      }
                    }
                    print("didnt recieve data");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ),
            )
        )
    );
  }

  @override
  void provideFile(File image) {
    print("image received");
    profilePicController = image;
  }
  void _bindData(Map<String, dynamic> data){
    if(data.containsKey("profilepic")){
      if(data["profilepic"] == null){
        data["profilepic"] = "";
      }
      _profilePicture = data["profilepic"];
      print("pro : $_profilePicture");
    }
    if(data.containsKey("first name")){
      _firstName = data["first name"];
    }
    if(data.containsKey("lastname")){
      _lastName = data["lastname"];
    }
    if(data.containsKey("city")){
      _city = data["city"];
    }
    if(data.containsKey("province")){
      _province = data["province"];
    }
    if(data.containsKey("postal code")){
      _postalCode = data["postal code"];
    }
    if(data.containsKey("address")){
      _address = data["address"];
    }
    if(data.containsKey("weight")){
      _weight = data["weight"];
    }
    if(data.containsKey("diseases")){
      if(data["diseases"] != null) {
        _fetchedDiseases = data["diseases"];
      }
    }
    if(data.containsKey("allergyOne")){
      _allergyOne = data["allergyOne"];
    }
    if(data.containsKey("allergyTwo")){
      _allergyTwo = data["allergyTwo"];
    }
    if(data.containsKey("allergyThree")){
      _allergyThree = data["allergyThree"];
    }
    if(data.containsKey("allergyFour")){
      _allergyFour = data["allergyFour"];
    }
    if(data.containsKey("allergyFive")){
      _allergyFive = data["allergyFive"];
    }
    if(data.containsKey("allergySix")){
      _allergySix = data["allergySix"];
    }
    if(data.containsKey("allergySeven")){
      _allergySeven = data["allergySeven"];
    }
    if(data.containsKey("allergyEight")){
      _allergyEight = data["allergyEight"];
    }
    if(data.containsKey("allergyNine")){
      _allergyNine = data["allergyNine"];
    }
    if(data.containsKey("allergyTen")){
      _allergyTen = data["allergyTen"];
    }
    if(data.containsKey("allergyEleven")){
      _allergyEleven = data["allergyEleven"];
    }
    if(data.containsKey("allergyTwelve")){
      _allergyTwelve = data["allergyTwelve"];
    }
  }
}
