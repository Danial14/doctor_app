import 'dart:async';



import 'package:cliniconline/screens/login.dart';
import 'package:cliniconline/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _formState = GlobalKey<FormState>();
  final _hidePassword = ValueNotifier<bool>(true);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      _whereToNavigate();

    });
  }
  void _whereToNavigate() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isAlreadyInstalled = sharedPreferences.getBool("isAlreadyInstalled");
    if(isAlreadyInstalled == null){
      await sharedPreferences.setBool("isAlreadyInstalled", true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
        return OnboardingScreen01();
      }));
    }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
        return EmailLoginScreen(null);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Splash.png'),
            fit: BoxFit.fill
          ),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 10,),
            const Text('Clinic Online',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik'

            ),)
          ],
        ),

      ),
    );
  }
}
