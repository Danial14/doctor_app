import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cliniconline/screens/doctor_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  String _profilePicUrl = "";
  late ProvideFile _provideFile;
  ProfilePicture(String profilePicUrl, ProvideFile provideFile){
    this._profilePicUrl = profilePicUrl;
    this._provideFile = provideFile;
  }
  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{

        ImagePicker imagePicker = ImagePicker();
        final image = await imagePicker.pickImage(source: ImageSource.camera);
        _imageFile = File(image!.path);
        setState((){
          widget._provideFile.provideFile(_imageFile!);
        });
      },
      child: _imageFile != null ? CircleAvatar(
        backgroundImage: FileImage(_imageFile!),
        backgroundColor: Colors.transparent,
        radius: 60,
      ) : widget._profilePicUrl == "" ? const CircleAvatar(
        backgroundImage: AssetImage("assets/images/user.jpg"),
        backgroundColor: Colors.transparent,
        radius: 60,
      ) : CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(widget._profilePicUrl),
        backgroundColor: Colors.transparent,
        radius: 60,
      )
    );
  }
}
