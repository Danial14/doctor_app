import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  late bool _isChecked;
  late String _label;
  late List _diseases;
  CustomCheckBox(bool isChecked, String label, List diseases){
    this._isChecked = isChecked;
    this._label = label;
    this._diseases = diseases;
  }

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(value: widget._isChecked,onChanged: (val){
      print("checked: ${val!}");
      widget._isChecked = val!;
      if(val!) {
        widget._diseases.add(widget._label);
      }
      else{
        widget._diseases.remove(widget._label);
      }
      print("checked: ${widget._isChecked}");
      setState(() {
      });
    }, title: Text(widget._label),

    );
  }
}
