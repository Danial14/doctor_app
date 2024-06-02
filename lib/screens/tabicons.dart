import 'package:flutter/material.dart';

class TabIcons extends StatefulWidget {
  late Function _callBack;
  TabIcons(Function callback){
    this._callBack = callback;
  }

  @override
  State<TabIcons> createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: CircleAvatar(
        radius: 20,
        //backgroundColor: Colors.green,
        child: Icon(Icons.home),
      ),
    );
  }
}
