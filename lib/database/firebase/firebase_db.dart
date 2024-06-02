import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../screens/phonelogin.dart';

class FirebaseDatabase{
  late final FirebaseAuth _firebaseAuth;
  static FirebaseDatabase? _firebaseDatabase;
  late final FirebaseFirestore _firebaseFirestore;

  List _favouriateDoctorsList = [];
  FirebaseDatabase._(){
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseFirestore = FirebaseFirestore.instance;
  }
  static FirebaseDatabase get getInstance{
    if(_firebaseDatabase == null){
      _firebaseDatabase = FirebaseDatabase._();
    }
    return _firebaseDatabase!;
  }
  Future<String> patientsignUpWithCredientials({required String email, required String password, required String username, required String mobileNo}) async{
    return await _patientSignUp(email: email, password: password, username: username, mobileNo: mobileNo);
  }
  Future<String> signUpWithCredientials({required String email, required String password, required String username, required String registrationNo, required String mobileNo}) async{
    return await _signUp(email: email, password: password, username: username, registrationNo: registrationNo, mobileNo: mobileNo);
  }
  Future<String> _signUp({required String email, required String password, required String username, required String registrationNo, required String mobileNo}) async{
    try{
      var collectionReference = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference.where("mobileNo", isEqualTo: mobileNo).get();
      if(snapshot.size == 0){
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        await collectionReference.add({
          "email" : email,
          "username" : username,
          "registrationNo" : registrationNo,
          "mobileNo" : mobileNo
        });
      }
      else{
        return "User with this mobile number already exists";
      }
      return "Signup successful";
    }
    on FirebaseAuthException catch(e){
      return e.message!;
    }
    catch(e){
      return e.toString();
    }
  }
  Future<String> _patientSignUp({required String email, required String password, required String username, required String mobileNo}) async{
    try{
      var collectionReference = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference.where("mobileNo", isEqualTo: mobileNo).get();
      if(snapshot.size == 0){
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        await collectionReference.add({
          "email" : email,
          "username" : username,
          "mobileNo" : mobileNo
        });
      }
      else{
        return "User with this mobile number already exists";
      }
      return "Signup successful";
    }
    on FirebaseAuthException catch(e){
      return e.message!;
    }
    catch(e){
      return e.toString();
    }
  }
  Future<String> loginWithCredientials({required String email, required String password, required bool isFirstTime}) async{
    return await _login(email: email, password: password, isFirstTime: isFirstTime);
  }

  Future<String> _login({required String email, required String password, required bool isFirstTime}) async{
    try{
      if(isFirstTime){
        await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        return "Login successful";
      }
      QuerySnapshot isDoctor = await _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors").where("email", isEqualTo: email).get();
      if(isDoctor.size > 0){
        await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        return "Login successfully as doctor";
      }
      else{
        QuerySnapshot isPatient = await _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Patients").where("email", isEqualTo: email).get();
        if(isPatient.size > 0){
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          return "Login successfully as patient";
        }
      }
      return "Login is not successful";
    }
    on FirebaseAuthException catch(e){
      return e.message!;
    }
  }
  Future<Map<String, String>> loginWithMobile({required String mobileNo}) async{
    try{
      var collectionReference = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference.where("mobileNo", isEqualTo: mobileNo).get();
      if(snapshot.size > 0) {
        print("number found");
        return {"response" : "Login successfully as Doctor", "email" : snapshot.docs[0].data()["email"] as String};
      }
      collectionReference = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      snapshot = await collectionReference.where("mobileNo", isEqualTo: mobileNo).get();
      if(snapshot.size > 0){
          return {"response" : "Login successfully as Patient", "email" : snapshot.docs[0].data()["email"] as String};
        }
      return {"response" : "User with this mobile no doesnot exist"};

    }
    on FirebaseAuthException catch(e){
      return {"response" : e.message!};
    }
    catch(e){
      return {"response" : e.toString()};
    }
  }
  Future<Map<String, dynamic>?> fetchDoctorData(String email) async{
    try{
      var collectionReference = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference.where("email", isEqualTo: email).get();
      if(snapshot.size > 0){
        print("user length: ${snapshot.size}");
        print("user data: ${snapshot.docs[0].data()}");
        return snapshot.docs[0].data();
      }
      return null;
    }
    catch(e){
      print(e);
    }
  }
  Future<Map<String, dynamic>?> fetchPatientData(String email) async{
    try{
      var collectionReference = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference.where("email", isEqualTo: email).get();
      if(snapshot.size > 0){
        print("user length: ${snapshot.size}");
        print("user data: ${snapshot.docs[0].data()}");
        return snapshot.docs[0].data();
      }
      return null;
    }
    catch(e){
      print(e);
    }
  }
  Future<String> updateDoctorProfile(Map<String, dynamic> data, String email, File? image) async{
    try {
      String imageUrl = await _uploadPicture(image, email);
      if(imageUrl != ""){
        data["profilepic"] = imageUrl;
      }
      var collectionReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference
          .where("email", isEqualTo: email).get();
      String docId = snapshot.docs[0].id;
      print("docid: ${docId}");
      var docReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Doctors/").doc(docId);
      await docReference.update(data);
      return "Profile updated";
    }
    catch(e){
      return "Profile not updated";
    }
  }
  Future<String> _uploadPicture(File? image, String email) async{
    if(image != null) {
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      var imageRef = firebaseStorage.ref().child("/images").child(
          "/$email.jpg/");
      var refTwo = await imageRef.putFile(image).whenComplete(() {
        print("image uploaded successful");
      });
      String imageUrl = await refTwo.ref.getDownloadURL();
      print("image url : $imageUrl");
      return imageUrl;
    }
    else{
      return "";
    }
  }
  Future<String> uploadAttachmentPicture(File? image, String email) async{
    print("uploading attachment picture");
    if(image != null) {
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      var imageRef = firebaseStorage.ref().child("/images").child(
          "/$email/attachments/${DateTime.now().toString()}.jpg/");
      var refTwo = await imageRef.putFile(image).whenComplete(() {
        print("image uploaded successful");
      });
      String imageUrl = await refTwo.ref.getDownloadURL();
      print("attachment image url : $imageUrl");
      return imageUrl;
    }
    else{
      return "";
    }
  }
  Future<String> updatePatientProfile(Map<String, dynamic> data, String email, File? image) async{
    try {
      String imageUrl = await _uploadPicture(image, email);
      if(imageUrl != ""){
        data["profilepic"] = imageUrl;
      }
      var collectionReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference
          .where("email", isEqualTo: email).get();
      String docId = snapshot.docs[0].id;
      print("docid: ${docId}");
      var docReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Patients/").doc(docId);
      await docReference.update(data);
      return "Profile updated";
    }
    catch(e){
      return "Profile not updated";
    }
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchLiveDoctors(){
    Stream<QuerySnapshot<Map<String, dynamic>>>? dataStream;
    try {
      var collectionReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      dataStream = collectionReference.where(
          "live_status", isEqualTo: "live").snapshots();
    }
    catch(e){
      print("error fetching live doctors");
    }
    return dataStream!;
  }
  Future<void> updateDoctorLiveStatus(String email, String? deviceToken, String status) async{
    try{
      var collectionReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      var doctor = await collectionReference.where("email", isEqualTo: email).get();
      doctor.docs[0].reference.update({
        "live_status" : status,
        "deviceToken" : deviceToken!
      });
    }
    catch(e){

    }
  }
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> doctorFilterSearch(String searchWord) async{
    Stream<QuerySnapshot<Map<String, dynamic>>>? dataStream;
    try {
      var collectionReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      var specializationQueryRef = collectionReference.where("specialization", arrayContainsAny: [searchWord]);
      var specializationDocs = (await specializationQueryRef.get()).docs;
      if(specializationDocs.isNotEmpty){
        return specializationQueryRef.snapshots();
      }
      /*todo code for querying symtoms searchWord
      if(){
        symtoms check code todo
      }*/
    }
    catch(e){
      print("cant find specialization");
    }
    return null;
  }
  Future<List?> getFavouriateDoctorsList(String email) async{
    try{
      var collectionReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference
          .where("email", isEqualTo: email).get();
      _favouriateDoctorsList = snapshot.docs[0].data()["favouriate_doctors"];
      return _favouriateDoctorsList;
    }
    catch(e){

    }
    return null;
  }
  Future<void> updateFavouriateDoctorLive(String email, List favouriateDoctors) async{
    try{
      var collectionReference = _firebaseFirestore.collection(
          "Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      var patient = await collectionReference.where("email", isEqualTo: email).get();
      patient.docs[0].reference.update({
        "favouriate_doctors" : favouriateDoctors
      });
    }
    catch(e){

    }
  }
  Future<void> removeFavouriateDoctor(String email, int index) async{
    _favouriateDoctorsList.removeAt(index);
   await updateFavouriateDoctorLive(email, _favouriateDoctorsList);
  }
  Stream<QuerySnapshot<Map<String, dynamic>>>? getDoctorSnapShotForVideoCall(String email){
    try{
      var doctorSnapshot = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors").where("email", isEqualTo: email).snapshots();
      return doctorSnapshot;
    }
    catch(e){

    }
    return null;
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getPatientStream(String patientEmail){
    return _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Patients").where("email", isEqualTo: patientEmail).snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getDoctorStream(String doctorEmail){
    return _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors").where("email", isEqualTo: doctorEmail).snapshots();
  }
  Future<void> sendMsgPatient(String userEmail, String doctorEmail, Map<String, dynamic> message) async{
    try {
      var usercollection = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      var doctorcollection = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      var patientReference = (await usercollection.where('email', isEqualTo: userEmail).get()).docs[0].reference;
      var doctorReference = (await doctorcollection.where('email', isEqualTo: doctorEmail).get()).docs[0].reference;
      doctorReference.update({
        'chats.sendmsg':FieldValue.arrayUnion([message]),

      });
      patientReference.update({
        'chats.receivedmsg':FieldValue.arrayUnion([message]),
      });
      print('send msg');
    }
    catch(e){
      print(e.toString());
    }
  }

  Future<void> sendMsgDoctor(String doctorEmail, String patientEmail, Map<String, dynamic> message) async{
    try {
      var usercollection = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Patients");
      var doctorcollection = _firebaseFirestore.collection("Users/Jz8tTzhPpRB5mEQJsHNd/Doctors");
      var doctorReference = (await doctorcollection.where('email', isEqualTo: doctorEmail).get()).docs[0].reference;
      var patientReference = (await usercollection.where('email', isEqualTo: patientEmail).get()).docs[0].reference;
      patientReference.update({
        'chats.sendmsg':FieldValue.arrayUnion([message]),

      });
      doctorReference.update({
        'chats.receivedmsg':FieldValue.arrayUnion([message]),
      });
      print('send msg');
    }
    catch(e){
      print(e.toString());
    }
  }
}