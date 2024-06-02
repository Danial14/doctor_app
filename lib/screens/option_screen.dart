import 'package:cliniconline/screens/login.dart';
import 'package:cliniconline/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'doctor_signup_screen.dart';

class OptionScreen extends StatefulWidget {
  String _patient = "Patient";
  String _doctor = "Doctor";
  OptionScreen(){

  }
  OptionScreen.init(String patient, String doctor){
    this._patient = patient;
    this._doctor = doctor;
  }
  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/Signup.png'),
    fit: BoxFit.fill
    ),

    ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2,),
            const Text('Please Select',style: TextStyle(
                fontSize: 24,
                fontFamily: 'Rubik-Medium'

            ),),
            const SizedBox(height: 30,),
            InkWell(
              onTap: (){
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupScreen()),);
                if(widget._patient == "Patient signup"){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                    return SignupScreen();
                  }));
                  return;
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                  return EmailLoginScreen(false);
                }));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff00AC6E)
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/patient2.png')),
                    Text(widget._patient,style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 22,
                      color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DoctorSignupScreen()));
                if(widget._doctor == "Doctor signup"){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                    return DoctorSignupScreen();
                  }));
                  return;
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                  return EmailLoginScreen(true);
                }));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff00AC6E)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/doctor.png')),
                    Text(widget._doctor,style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 22,
                      color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
