import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/widgets/new_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Chat extends StatefulWidget {
  late String _doctorEmail;
  late String _patientEmail;
  late bool _isDoctor;
  Chat(String doctorEmail, String patientEmail, bool isDoctor){
    this._doctorEmail = doctorEmail;
    this._patientEmail = patientEmail;
    this._isDoctor = isDoctor;
  }

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  int _sentMessagesLength = 0;
  int _recieveMessageLength = 0;
  List _Messages = [];
  var _controller = TextEditingController();
  String _Message = "";
  var profilePic;
  File? _attachmentPic;
  ValueNotifier<bool> _isImageToBeInserted = ValueNotifier<bool>(false);
  var userName;
  ValueNotifier<bool> _imageNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> _sendMessageNotifier = ValueNotifier<bool>(false);
  File? _image;
  bool _secondaryCheck = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 5,
      right: 5
      ),
      width: screenSize.width,
      height: screenSize.height * 0.4,
      child: Column(
        children: <Widget>[
          Expanded
            (child: StreamBuilder(stream: widget._isDoctor ? FirebaseDatabase.getInstance.getDoctorStream(widget._doctorEmail) : FirebaseDatabase.getInstance.getPatientStream(widget._patientEmail), builder: (ctx, snapshot){
              print("stream");
              if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<String, dynamic> data = snapshot.data!.docs[0].data();
                Map<String, dynamic>? chats = data["chats"];
                profilePic = data["profilepic"];
                print("pro pic : ${profilePic}");
                userName = data["username"];
                if(chats != null) {
                  if (chats["receivedmsg"] != null && _recieveMessageLength != chats["receivedmsg"].length) {
                    _Messages.add(chats["receivedmsg"][chats["receivedmsg"].length - 1]);
                    _recieveMessageLength = chats["receivedmsg"].length;
                  }
                  else if (chats["sendmsg"] != null && _sentMessagesLength != chats["sendmsg"].length) {
                    _Messages.add(chats["sendmsg"][chats["sendmsg"].length - 1]);
                    _sentMessagesLength = chats["sendmsg"].length;
                  }
                  _Messages = _Messages.reversed.toList();
                  return ListView.builder(itemBuilder: (ctx, position) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(_Messages[position]["profilepic"]),
                      ),
                      title: Text(_Messages[position]["username"], style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Messages[position].containsKey("attachment") ? InkWell(
                            onTap: (){
                              showModalBottomSheet(context: context, builder: (ctx){
                                return Container(
                                  width: screenSize.width,
                                  height: screenSize.height * 0.6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(_Messages[position]["attachment"]),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                );
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(_Messages[position]["attachment"]),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                          ) : Container(),
                          SizedBox(height: 5,),
                          _Messages[position].containsKey("Message") ? Text(_Messages[position]["Message"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),) :
                              Container()
                        ],
                      )
                    );
                  },
                    itemCount: _Messages.length,
                  );
                }
                else{
                  return Container();
                }

          })),
          SizedBox(height: 10,),
          Container(
            width: screenSize.width,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [Expanded
                  (flex: 1,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _imageNotifier,
                    builder: (ctx, value, ch){
                      if(value || _secondaryCheck){
                        return InkWell(onTap: () async{
                          var file = await ImagePicker().pickImage(source: ImageSource.camera);
                          if(file != null) {
                            _image = File(file.path);
                            _imageNotifier.value = !_imageNotifier.value;
                          }
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
                          if(file != null) {
                            _image = File(file.path);
                            _imageNotifier.value = true;
                            _secondaryCheck = true;
                            _sendMessageNotifier.value = true;
                          }
                        },
                          child: Icon(Icons.camera_alt_rounded, color: Colors.white,),
                          backgroundColor: Color(0xff0EBE7E),
                          shape: CircleBorder(

                          ),
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
                          if(!_secondaryCheck){
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
                              if(value || _secondaryCheck){
                                return FloatingActionButton(onPressed: () async{
                                  if(_Message.isNotEmpty && _secondaryCheck){
                                    FocusScope.of(context).unfocus();
                                    _controller.clear();
                                    //upload image to firestore and pick imageurl

                                    if(widget._isDoctor){
                                      // send message to patient
                                      String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._doctorEmail);
                                      await FirebaseDatabase.getInstance.sendMsgPatient(widget._patientEmail, widget._doctorEmail, {"Message" : _Message, "profilepic" : profilePic, "username" : userName, "attachment" : imageUrl});
                                    }
                                    else{
                                      // send message to doctor
                                      String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._patientEmail);
                                      await FirebaseDatabase.getInstance.sendMsgDoctor(widget._doctorEmail, widget._patientEmail, {"Message" : _Message, "profilepic" : profilePic, "username" : userName, "attachment" : imageUrl});
                                    }
                                    _imageNotifier.value = false;
                                    _secondaryCheck = false;
                                  }
                                  else if(_Message.isNotEmpty){
                                    FocusScope.of(context).unfocus();
                                    _controller.clear();
                                    if(widget._isDoctor){
                                      // send message to patient
                                      await FirebaseDatabase.getInstance.sendMsgPatient(widget._patientEmail, widget._doctorEmail, {"Message" : _Message, "profilepic" : profilePic, "username" : userName});
                                    }
                                    else{
                                      // send message to doctor
                                      await FirebaseDatabase.getInstance.sendMsgDoctor(widget._doctorEmail, widget._patientEmail, {"Message" : _Message, "profilepic" : profilePic, "username" : userName});
                                    }
                                  }
                                  else if(_secondaryCheck){
                                    if(widget._isDoctor){
                                      // send message to patient
                                      String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._doctorEmail);
                                      await FirebaseDatabase.getInstance.sendMsgPatient(widget._patientEmail, widget._doctorEmail, {"profilepic" : profilePic, "username" : userName, "attachment" : imageUrl});
                                    }
                                    else{
                                      // send message to doctor
                                      String imageUrl = await FirebaseDatabase.getInstance.uploadAttachmentPicture(_image, widget._patientEmail);
                                      await FirebaseDatabase.getInstance.sendMsgDoctor(widget._doctorEmail, widget._patientEmail, {"profilepic" : profilePic, "username" : userName, "attachment" : imageUrl});
                                    }
                                    _imageNotifier.value = false;
                                    _secondaryCheck = false;
                                  }
                                  // send message
                                  _Message = "";
                                  _image = null;
                                  _sendMessageNotifier.value = false;
                                },
                                  child: Center
                                    (child: Icon(Icons.send_rounded, color: Colors.white,)),
                                  backgroundColor: Color(0xff0EBE7E),
                                  shape: CircleBorder(),
                                );
                              }
                              else{
                                return FloatingActionButton(onPressed: null, child: Center(child: Icon(Icons.send_rounded)),
                                shape: CircleBorder(),
                                  backgroundColor: Colors.grey,
                                );
                              }
                            },
                          )
                      ),
                    ),
                  ),]
            ),
            padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
            margin: EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
  Future<File?> _getImage() async{
    try{
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      return File(image!.path);
    }
    catch(e){
      print("error in chat image");
    }
  }
}
