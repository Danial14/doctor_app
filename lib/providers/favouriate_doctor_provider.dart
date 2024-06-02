import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:flutter/material.dart';

class FavouriateDoctorProvider with ChangeNotifier{
  List _favouriateDoctors = [];
  List _searchDoctors = [];
  Future<bool> fetchFavouiateDoctorsListFromFirebase(String email) async{
    var favouriateDoctors = await FirebaseDatabase.getInstance.getFavouriateDoctorsList(email);
    if(favouriateDoctors != null){
      print("data rec");
      for(int i = 0; i < favouriateDoctors.length; i++){
        _favouriateDoctors.add((await favouriateDoctors[i].get()).data());
      }
      return true;
    }
    print("data not rec");
    return false;
  }
  void removeFavouriateDoctor(String email, int index, bool isSearchMode) async{
    if(isSearchMode){
      var item = _searchDoctors.removeAt(index);
      int itemIndex = _favouriateDoctors.indexOf(item);
      if(itemIndex > -1){
        await FirebaseDatabase.getInstance.removeFavouriateDoctor(email, itemIndex);
        _favouriateDoctors.removeAt(itemIndex);
        notifyListeners();
      }
    }
    else if(_favouriateDoctors.isNotEmpty) {
      await FirebaseDatabase.getInstance.removeFavouriateDoctor(email, index);
      _favouriateDoctors.removeAt(index);
      print("fav doc removed");
      notifyListeners();
    }
  }
  void searchDoctor(String name){
    _searchDoctors = _favouriateDoctors.where((element){
      bool searchResult = element["username"].contains(name);
      return searchResult;
    }).toList();
    if(_searchDoctors.isNotEmpty){
      notifyListeners();
    }
  }
  List get getFavouriateDoctorsList{
    return [..._favouriateDoctors];
  }
  List get getFavouriateDoctorsSearchList{
    return [..._searchDoctors];
  }
  void removeAllDoctors(){
    _favouriateDoctors = [];
    _searchDoctors = [];
  }
}