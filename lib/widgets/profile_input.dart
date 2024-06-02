import 'package:flutter/material.dart';

class ProfileInput extends StatefulWidget {
  String _hintText = "";
  var _keyboardType;
  var _controller;
  late final Map<String, dynamic> _data;
  ProfileInput(String hintText, var keyboardType, var controller){
    this._hintText = hintText;
    this._keyboardType = keyboardType;
    this._controller = controller;
  }
  @override
  State<ProfileInput> createState() => _ProfileInputState();
}

class _ProfileInputState extends State<ProfileInput> {
  bool _isReadOnly = true;
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          padding: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey
                  )
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: widget._controller,
                  keyboardType: widget._keyboardType,
                  onSaved: (val){
                    print("onSave : ${val}");
                    widget._controller.text = val;
                  },
                  //initialValue: widget._hintText,
                  readOnly: _isReadOnly,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      hintText: widget._hintText,
                      border: InputBorder.none
                  ),
                ),
              ),
              //SizedBox(width: 5,),
              InkWell(
                onTap: (){
                  print("test disabled");
                  setState(() {
                    this._isReadOnly = false;
                    FocusScope.of(context).requestFocus(_focusNode);
                  });
                },
                child: Container(
                  width: 40,
                  child: Icon(
                      Icons.edit
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
}
