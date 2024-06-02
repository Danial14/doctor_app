import 'package:cliniconline/screens/phonelogin.dart';
import 'package:flutter/material.dart';

import 'OnboardingScreenThree.dart';
import 'login.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({Key? key}) : super(key: key);
  /*@override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          Container(
            width: screenSize.width,
            height: 900,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 212,
                  top: screenSize.height * 0.78,
                  child: Container(
                    width: 216,
                    height: 216,
                    decoration: ShapeDecoration(
                      color: Color(0x4C0EBE7E),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 155,
                  top: screenSize.height * 0.50,
                  child: TextButton(onPressed: () {},
                      child: Text(
                        'Skip',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          height: 23.18,
                          letterSpacing: -0.30,
                        ),
                      )
                  ),
                ),
                Positioned(
                  left: 40,
                  top: screenSize.height * 0.79,
                  child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                          return OnboardingScreenThree();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF00AC6E),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        width: 280,
                        height: 54,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 97,
                              top: 19,
                              child: SizedBox(
                                width: 101,
                                height: 17,
                                child: Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Positioned(
                  left: 80,
                  top: screenSize.height * 0.56,
                  child: Text(
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
                ),
                Positioned(
                  left: -104,
                  top: -20,
                  child: Container(
                    //color: Colors.red,
                    width: 497,
                    height: 447,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 260,
                          top: 0,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.98, -0.19),
                                end: Alignment(-0.98, 0.19),
                                colors: [Color(0xFF0EBE7E), Color(0xFF07D9AD)],
                              ),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: screenSize.width * 0.45,
                          top: screenSize.height * 0.10,
                          child: Container(
                            width: 280,
                            height: 280,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/doctor.png"),
                                fit: BoxFit.fill,
                              ),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 9,
                  child: Container(
                    width: 349,
                    height: 18,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            width: 54,
                            height: 18,
                            child: Text(
                              '9:41',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 326.01,
                          top: 2.96,
                          child: Container(
                            width: 22.99,
                            height: 10.71,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 20.79,
                                    height: 10.71,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 0.50, color: Color(0xFF222222)),
                                        borderRadius: BorderRadius.circular(2.67),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 1.89,
                                  top: 1.89,
                                  child: Container(
                                    width: 17.01,
                                    height: 6.93,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF222222),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1.33),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 306.79,
                          top: 2.95,
                          child: Container(
                            width: 14.49,
                            height: 10.40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://via.placeholder.com/14x10"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 286,
                          top: 3.27,
                          child: Container(
                            width: 16.07,
                            height: 10.08,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://via.placeholder.com/16x10"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),),
    );
  }*/
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
                  "assets/images/Onboarding_screen_02.png",
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
              'Ab Doctor Se Her Waqt\nRaabta Mumkin Hai',
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
                      return OnboardingScreenThree();
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
