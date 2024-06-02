import 'package:cliniconline/screens/phonelogin.dart';
import 'package:flutter/material.dart';

import 'OnboardingScreenTwo.dart';
import 'login.dart';

class OnboardingScreen01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(body: SafeArea(child: SingleChildScrollView(
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Onboarding_screen_01_bg.png",
            ),
            fit: BoxFit.cover
          )
        ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenSize.height * 0.6,
              ),
              Text(
                'Pareshani Pooch ker\nNahi Aati',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 26,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.30,
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                child: Container(
                  width: screenSize.width * 0.8,
                  height: 60,
                  child: Center(
                    child: Text("Get started",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff00AC6E),
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx){
                        return OnboardingScreenTwo();
                      }
                  ));
                },
              ),
              SizedBox(height: 5,),
              TextButton(onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx){
                    return EmailLoginScreen(null);
                  }
                ));
              }, child: Text(
                'Skip',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.30,
                ),
              ))
            ],
          )
      ),

    )));
  }
}