import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/screens/doctor_profile.dart';
import 'package:cliniconline/screens/doctor_signup_screen.dart';
import 'package:cliniconline/screens/finddoctors.dart';
import 'package:cliniconline/screens/option_screen.dart';
import 'package:cliniconline/screens/patient_profile.dart';
import 'package:cliniconline/screens/phonelogin.dart';
import 'package:cliniconline/screens/signup_screen.dart';
import 'package:cliniconline/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class EmailLoginScreen extends StatefulWidget {
  bool? _isDoctor;
  EmailLoginScreen(bool? isDoctor){
    this._isDoctor = isDoctor;
  }
  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  var _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Splash.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(width: screenSize.width,
                    height: screenSize.height * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text("Welcome back",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("You can search course apply course and find", style: TextStyle(
                            color: Color(0xff677294),
                            fontSize: 12
                        ),
                        textAlign: TextAlign.center,
                        ),
                        Text("scholarship for abroad studies", textAlign: TextAlign.center, style: TextStyle(
                            color: Color(0xff677294),
                            fontSize: 12
                        ))
                      ],
                    )
                ),
                SizedBox(height: 10,),
                Container(
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xff677294).withOpacity(0.16)
                                      )
                                  ),
                                  suffixIcon: InkWell(
                                    child: Image.asset("assets/images/check.png",),
                                    onTap: (){

                                    },
                                  )
                              ),
                              onSaved: (email){
                                print("OnSave");
                                print(email!);
                                _email = email!;
                              },
                              validator: (email){
                                print("validator");
                                if(email! == "" || !email.contains("@")){
                                  return "Please enter valid email address";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xff677294).withOpacity(0.16)
                                      )
                                  ),
                                  suffixIcon: InkWell(
                                    child: Image.asset("assets/images/check.png",),
                                    onTap: (){

                                    },
                                  )
                              ),
                              onSaved: (password){
                                print("OnSave");
                                print(password!);
                                _password = password!;
                              },
                              validator: (password){
                                print("validator");
                                if(password!.length < 6){
                                  return "Please enter valid password";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              child: Container(
                                width: screenSize.width * 0.65,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Color(0xff00AC6E),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(
                                  child: Text("Login",
                                    style: TextStyle(color: Color(0xffFFFFFF),
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                _validateUserCredientials();
                              },
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            TextButton(
                              onPressed: (){
                                /*if(widget._isDoctor!){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                                    return DoctorSignupScreen();
                                  }));
                                }
                                else{
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                                    return SignupScreen();
                                  }));
                                }*/
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                                  return OptionScreen.init("Patient signup", "Doctor signup");
                                }));
                              },
                              child: Text("Don't have an account? Join us",
                                style: TextStyle(
                                    color: Color(0xff0EBE7F),
                                    fontSize: 12
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            TextButton(
                              onPressed: (){
                                print("forgot password");
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                                    return PhoneLoginScreen();
                                  }));
                              },
                              child: const Text("Forgot password",
                                style: TextStyle(
                                    color: Color(0xff0EBE7F),
                                    fontSize: 12
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _validateUserCredientials() async{
    Size screenSize = MediaQuery.of(context).size;
    var formState = _formKey.currentState!;
    if(formState.validate()) {
      formState.save();
      /*try {
        var auth = FirebaseAuth.instance;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: _email, password: _password);
        print("User successfully login: ${userCredential.user!.email}");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return FindDoctors();
        }));
      }
      on FirebaseAuthException catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
      }*/
      FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance;
      if(widget._isDoctor != null){
          // first time login after signup
        String response = await firebaseDatabase.loginWithCredientials(email: _email, password: _password, isFirstTime: true);
        if(response == "Login successful"){
          if(widget._isDoctor!){
            _showGoLivePopup();
          }
          else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
              return PatientProfile(_email);
            }));
          }
        }
        return;
      }
      String response = await firebaseDatabase.loginWithCredientials(email: _email, password: _password, isFirstTime: false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
      if(response == "Login successfully as doctor"){
        _showGoLivePopup();
      }
      else if("Login successfully as patient" == response){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return TabsScreen(_email);
        }));
      }
    }
  }
  void _showGoLivePopup() async{
    Size screenSize = MediaQuery.of(context).size;
    await showModalBottomSheet(isDismissible: false,context: context, builder: (ctx){
      return Container(
        width: screenSize.width,
        height: screenSize.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Do you want to go live"),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () async{
                  String? deviceToken = await FirebaseMessaging.instance.getToken();
                  print("device token from fcM : ${deviceToken}");
                  await FirebaseDatabase.getInstance.updateDoctorLiveStatus(_email, deviceToken, "live");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                    return DoctorProfile(_email);
                  }));
                },
                    child: Text("Yes")),
                SizedBox(width: 5,),
                ElevatedButton(onPressed: () async{
                  await FirebaseDatabase.getInstance.updateDoctorLiveStatus(_email, "", "not live");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                    return DoctorProfile(_email);
                  }));
                },
                    child: Text("No")),
              ],
            )
          ],
        ),
      );
    });
  }
}
