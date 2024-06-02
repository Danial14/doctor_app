
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database/firebase/firebase_db.dart';

class NewMessage extends StatefulWidget {
  late String _doctorEmail, _patientEmail, _profilePic, _userName;
  late bool _isDoctor;
  NewMessage(String doctorEmail, String patientEmail, bool isDoctor, String profilePic, String userName){
    this._isDoctor = isDoctor;
    this._patientEmail = patientEmail;
    this._doctorEmail = doctorEmail;
    this._profilePic = profilePic;
    this._userName = userName;
  }
  NewMessage.def(){

  }
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  ValueNotifier<bool> _imageNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> _sendMessageNotifier = ValueNotifier<bool>(false);
  String _Message = "";
  File? _image;

  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: Text("cxc"),),
      body: Container(
          width: screenSize.width,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [Expanded
              (flex: 1,
              child: ValueListenableBuilder<bool>(
          valueListenable: _imageNotifier,
          builder: (ctx, value, ch){
              if(value){
                return InkWell(onTap: () async{
                  var file = await ImagePicker().pickImage(source: ImageSource.camera);
                  _image = File(file!.path);
                },
                    child: Card(
                      shape: CircleBorder(),
                      color: Color(0xff0EBE7E),
                      elevation: 6,
                      child: CircleAvatar(
                        backgroundImage: FileImage(_image!),
                      ),
                    ));
              }
              else{
                return FloatingActionButton(onPressed: () async{
                  var file = await ImagePicker().pickImage(source: ImageSource.camera);
                  _image = File(file!.path);
                  _imageNotifier.value = true;
                },
                  child: Icon(Icons.camera_alt_rounded, color: Colors.white,),
                  backgroundColor: Color(0xff0EBE7E),
                  shape: CircleBorder(),
                );
              }
          },
        ),
      ),
              Expanded(
                flex: 4,
                child: TextFormField(
                controller: _controller,
                onChanged: (val){
                  if(val.isNotEmpty){
                    _Message = val;
                    if(!_sendMessageNotifier.value){
                      _sendMessageNotifier.value = true;
                    }
                  }
                  else{
                    _Message = val;
                    if(!_imageNotifier.value){
                      _sendMessageNotifier.value = false;
                    }
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add a Comment...",
                  hintStyle: TextStyle(
                    color: Color(0xff677294).withOpacity(0.8)
                  ),
                  suffixIcon: ValueListenableBuilder<bool>(
                    valueListenable: _sendMessageNotifier,
                    builder: (ctx, value, ch){
                      if(value){
                        return FloatingActionButton(onPressed: () async{
                          if(_Message.isNotEmpty && _imageNotifier.value){
                            FocusScope.of(context).unfocus();
                            _controller.clear();
                            //upload image to firestore and pick imageurl

                            if(widget._isDoctor){
                              // send message to patient
                              String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._doctorEmail);
                              await FirebaseDatabase.getInstance.sendMsgPatient(widget._patientEmail, widget._doctorEmail, {"Message" : _Message, "profilepic" : widget._profilePic, "username" : widget._userName, "attachment" : imageUrl});
                            }
                            else{
                              // send message to doctor
                              String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._patientEmail);
                              await FirebaseDatabase.getInstance.sendMsgDoctor(widget._doctorEmail, widget._patientEmail, {"Message" : _Message, "profilepic" : widget._profilePic, "username" : widget._userName, "attachment" : imageUrl});
                            }
                            _imageNotifier.value = false;
                          }
                          else if(_Message.isNotEmpty){
                            FocusScope.of(context).unfocus();
                            _controller.clear();
                            if(widget._isDoctor){
                              // send message to patient
                              await FirebaseDatabase.getInstance.sendMsgPatient(widget._patientEmail, widget._doctorEmail, {"Message" : _Message, "profilepic" : widget._profilePic, "username" : widget._userName});
                            }
                            else{
                              // send message to doctor
                              await FirebaseDatabase.getInstance.sendMsgDoctor(widget._doctorEmail, widget._patientEmail, {"Message" : _Message, "profilepic" : widget._profilePic, "username" : widget._userName});
                            }
                          }
                          else if(_imageNotifier.value){
                            if(widget._isDoctor){
                              // send message to patient
                              String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._doctorEmail);
                              await FirebaseDatabase.getInstance.sendMsgPatient(widget._patientEmail, widget._doctorEmail, {"profilepic" : widget._profilePic, "username" : widget._userName, "attachment" : imageUrl});
                            }
                            else{
                              // send message to doctor
                              String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._patientEmail);
                              await FirebaseDatabase.getInstance.sendMsgDoctor(widget._doctorEmail, widget._patientEmail, {"profilepic" : widget._profilePic, "username" : widget._userName, "attachment" : imageUrl});
                            }
                            _imageNotifier.value = false;
                          }
                          // send message
                          _Message = "";
                          _image = null;
                          _sendMessageNotifier.value = false;
                        },
                        child: Icon(Icons.send_rounded, color: Colors.white,),
                          backgroundColor: Color(0xff0EBE7E),
                          shape: CircleBorder(),
                        );
                      }
                      else{
                        return FloatingActionButton(onPressed: null, child: Icon(Icons.send_rounded),);
                      }
                    },
                  )
                ),
            ),
              ),]
          ),
          padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
          margin: EdgeInsets.all(10),
        ),
    );
  }
}
