import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavouriateHeart extends StatefulWidget {
  late Function(bool, DocumentReference) _callBack;
  late bool _favouriatestatus;
  late DocumentReference _data;
  FavouriateHeart(bool favouriateStatus, Function(bool, DocumentReference) callBack, DocumentReference data){
    this._favouriatestatus = favouriateStatus;
    this._callBack = callBack;
    this._data = data;
    print("fav status : $favouriateStatus");
  }

  @override
  State<FavouriateHeart> createState() => _FavouriateHeartState();
}

class _FavouriateHeartState extends State<FavouriateHeart> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget._favouriatestatus = !widget._favouriatestatus;
        print(widget._favouriatestatus);
        setState(() {
          widget._callBack(widget._favouriatestatus, widget._data);
        });
      },
      child: widget._favouriatestatus ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border),
    );
  }
}
