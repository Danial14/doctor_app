import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:flutter/material.dart';

class LiveDoctorProvider with ChangeNotifier{
  List _liveDoctorData = [];
  void fetchLiveDoctors() async{
    FirebaseDatabase.getInstance.fetchLiveDoctors();
  }
}