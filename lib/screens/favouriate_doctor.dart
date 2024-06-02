import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/providers/favouriate_doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class MyFavouriateDoctorScreen extends StatefulWidget {
  late String _email;
  MyFavouriateDoctorScreen(String email){
    this._email = email;
  }

  @override
  State<MyFavouriateDoctorScreen> createState() => _MyFavouriateDoctorScreenState();
}

class _MyFavouriateDoctorScreenState extends State<MyFavouriateDoctorScreen> {
  var _dataFuture;
  bool _searchMode = false;

  var _searchController = TextEditingController();
  var _favouriateDoctorProvider;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Splash.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 20,),
                  Container(width: screenSize.width,
                    height: screenSize.height * 0.2,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.arrow_back_ios,size: 10),
                            ),
                          ),
                          title: const Text("Find Doctors",
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenSize.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.16),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: const Offset(2,7)
                                )
                              ]
                          ),
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: InkWell(
                                  child: Icon(Icons.search,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  onTap: () async{
                                    _searchMode = true;
                                    _favouriateDoctorProvider.searchDoctor(_searchController.text);
                                  },
                                ),
                                hintText: "Search Live Doctors",
                                suffixIcon: InkWell(
                                  child: Icon(Icons.close,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  onTap: (){
                                    _searchMode = false;
                                    _searchController.text = "";
                                    setState(() {

                                    });
                                  },
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  Expanded(flex: 1,
                    child: Container(
                      width: screenSize.width * 0.9,
                      height: screenSize.height * 0.55,
                      child: FutureBuilder<bool>(
                        future: _dataFuture,
                        builder: (ctx, snapshot){
                          if(snapshot.hasData){
                            return Consumer<FavouriateDoctorProvider>(
                              builder: (ctx, data, ch){
                                _favouriateDoctorProvider = data;
                                List favDoctors = _searchMode? data.getFavouriateDoctorsSearchList : data.getFavouriateDoctorsList;
                                print("Consumer: ");
                                return favDoctors.isNotEmpty ? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.8
                                ), itemBuilder: (ctx, position){
                                  return Card(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topRight,
                                          padding: EdgeInsets.only(right: 5, top: 5),
                                          child: InkWell(
                                            onTap: (){
                                              if(_searchMode){
                                                data.removeFavouriateDoctor(widget._email, position, _searchMode);
                                              }
                                              else{
                                                data.removeFavouriateDoctor(widget._email, position, false);
                                              }
                                            },
                                            child: Icon(Icons.favorite),
                                          ),
                                        ),
                                        SizedBox(height: 2,),
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage: NetworkImage(favDoctors[position]["profilepic"]),
                                        ),
                                        SizedBox(height: 5,),
                                        Text("Dr.${favDoctors[position]["username"]}",
                                          style: TextStyle(fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),

                                        ),
                                        SizedBox(height: 5,),
                                        Text("${favDoctors[position]["specialization"][0]}",

                                        ),
                                      ],
                                    ),
                                  );
                                },
                                  itemCount: _searchMode ? data.getFavouriateDoctorsSearchList.length : data.getFavouriateDoctorsList.length,
                                ) : Container();
                              },
                            );
                          }
                          else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      _dataFuture = Provider.of<FavouriateDoctorProvider>(context, listen: false).fetchFavouiateDoctorsListFromFirebase(widget._email);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<FavouriateDoctorProvider>(MyApp.navigatorKey.currentContext!, listen: false).removeAllDoctors();
    super.dispose();
  }
}
