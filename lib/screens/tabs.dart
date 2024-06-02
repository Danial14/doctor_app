import 'package:cliniconline/screens/finddoctors.dart';
import 'package:cliniconline/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'favouriate_doctor.dart';

class TabsScreen extends StatefulWidget {
  late String _email;
  TabsScreen(String email){
    print("tabs : ${email}");
    this._email = email;
  }

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> _pages = [];
  int _currentPageIndex = 0;
  int _currentTabIndex = -1;
  List<Color> _tabsBackgroundColor = [Colors.white, Colors.white];
  List<IconData> _icons = [Icons.home, Icons.favorite];

  @override
  void initState() {
    // TODO: implement initState
    print("tabs state : ${widget._email}");
    _pages = [
      FindDoctors(widget._email),
      MyFavouriateDoctorScreen(widget._email)
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: Container(
        width: screenSize.width,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.grey.shade200
        ),
        child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (ctx, position){
          return Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.15),
            child: InkWell(
              onTap: (){
                if(_currentTabIndex > -1){
                  if(_tabsBackgroundColor[_currentTabIndex] == Colors.white){
                    _tabsBackgroundColor.removeAt(_currentTabIndex);
                    _tabsBackgroundColor.insert(_currentTabIndex, Colors.green);
                  }
                  else{
                    _tabsBackgroundColor.removeAt(_currentTabIndex);
                    _tabsBackgroundColor.insert(_currentTabIndex, Colors.white);
                  }
                }
                if(_tabsBackgroundColor[position] == Colors.white){
                  _currentTabIndex = position;
                  _tabsBackgroundColor.removeAt(position);
                  _tabsBackgroundColor.insert(position, Colors.green);
                }
                else{
                  _currentTabIndex = position;
                  _tabsBackgroundColor.removeAt(position);
                  _tabsBackgroundColor.insert(position, Colors.white);
                }
                _changePage(position);
                setState(() {

                });
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: _tabsBackgroundColor[position],
                child: Icon(_icons[position]),
              ),
            ),
          );
        },
        itemCount: 2,
        )
        ,
      ),
    );
  }
  void _changePage(int position){
    if(position < 3){
      _currentPageIndex = position;
      setState(() {

      });
    }
  }
}
