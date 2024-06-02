import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/screens/doctor_profile.dart';
import 'package:cliniconline/screens/finddoctors.dart';
import 'package:cliniconline/screens/patient_profile.dart';
import 'package:cliniconline/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneLoginScreen extends StatefulWidget {
  PhoneLoginScreen(){}

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen>{
  var _formKey = GlobalKey<FormState>();
  String _phoneNumber = "";
  String _verificationId = "";
  AltSmsAutofill _altSmsAutofill = AltSmsAutofill();

  String? email;
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
                Container(width: screenSize.width,
                    height: screenSize.height * 0.25,
                    //color: Colors.red,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                         Text("Welcome back",
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
                            fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        ),
                        Text("scholarship for abroad studies", textAlign: TextAlign.center, style: TextStyle(
                            color: Color(0xff677294),
                            fontSize: 12
                        ))
                      ],
                    ),

                ),
                SizedBox(height: 10,),
                Container(
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.45,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            IntlPhoneField(initialCountryCode: "PK"
                              ,decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: const Color(0xff677294).withOpacity(0.16)
                                      )
                                  ),
                                  suffixIcon: InkWell(
                                    child: Image.asset("assets/images/check.png",),
                                    onTap: (){

                                    },
                                  )
                              ),
                              onCountryChanged: (country){
                                print("Country name: ${country.name}");
                                print("Country code: ${country.code}");
                                print("Country dial code: ${country.dialCode}");
                              },
                              onSaved: (phoneNumber){
                                print("OnSave");
                                print(phoneNumber!.completeNumber);
                                _phoneNumber = phoneNumber!.completeNumber;
                              },
                              validator: (phoneNumber){
                                print("validator");
                                if(!(phoneNumber!.isValidNumber())){
                                  return "Please enter valid phone number";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              child: Container(
                                width: screenSize.width * 0.65,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: const Color(0xff00AC6E),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: const Center(
                                  child: Text("Login",
                                    style: TextStyle(color: Color(0xffFFFFFF),
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                _validatePhoneNumber();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                         /*  const Text("Don't have an account? Join us",
                              style: TextStyle(
                                  color: Color(0xff0EBE7F),
                                  fontSize: 14
                              ),
                            )
*/                          ],
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
  void _validatePhoneNumber() async{

    var formState = _formKey.currentState!;
    if(formState.validate()) {
      formState.save();
     FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance;
     print("validate phone no : $_phoneNumber");
    Map<String, String> response = await firebaseDatabase.loginWithMobile(mobileNo: _phoneNumber);
    if(response["response"] == "Login successfully as Doctor" || response["response"] == "Login successfully as Patient") {
      var auth = FirebaseAuth.instance;
      email = response["email"];
      auth.verifyPhoneNumber(phoneNumber: _phoneNumber,
          verificationCompleted: (_) {
            print("Phone number verification completed");
            print(_.toString());
          },
          verificationFailed: (e) {
            print(e.message);
          },
          codeSent: (String verificationId, int? code) {
            print("code sent ${code}");
            //_verificationId = verificationId;
            _listenForSms(verificationId: verificationId, loginStatus: response["response"]!);
            //codeSent(verificationId: verificationId);

          },
          codeAutoRetrievalTimeout: (_) {
            print(_);
          });
    }
    else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response["response"]!)));
    }
  }
  }
  void _listenForSms({required String verificationId, required String loginStatus}) async{
    try{
      _verificationId = verificationId;
     String? sms = await _altSmsAutofill.listenForSms;
     print("otp sms: $sms");
     String smsCode = sms!.substring(0, 6);
     print("otp smscode: $smsCode");
     TextEditingController smsCodeController = TextEditingController();
     smsCodeController.text = smsCode;
     showModalBottomSheet(context: context, builder: (ctx){
       return SingleChildScrollView(child: Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height * 0.45,
           child: Column(
             children: <Widget>[
               SizedBox(height: 30),
               Container(
                 width: MediaQuery.of(context).size.width * 0.30,
                 height: 5,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30),
                     color: Colors.grey
                 ),
               ),
               const Padding(
                   padding: EdgeInsets.only(top: 10, left: 10),
                   child: ListTile(leading: Text("Enter 6 digits code",
                       style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold
                       )
                   )
                   )
               ),
               Container(child: PinCodeTextField(

                 controller: smsCodeController,
                 enableActiveFill: true,
                 autoDisposeControllers: true,
                 pinTheme: PinTheme(
                   shape: PinCodeFieldShape.box,
                   borderRadius: BorderRadius.circular(10),
                   inactiveColor: Colors.grey.withOpacity(0.3),
                   selectedColor: Colors.grey.withOpacity(0.3),
                   selectedFillColor: Colors.grey.withOpacity(0.3),
                   activeFillColor: Colors.grey.withOpacity(0.3),
                 ),
                 length: 6,
                 appContext: ctx,
               ),
                   width: MediaQuery.of(context).size.width * 0.8
               ),
               const SizedBox(height: 15),
               InkWell(
                   onTap: () async{
                     var auth = FirebaseAuth.instance;
                     var credientials = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: smsCodeController.text);
                     try{
                       await auth.signInWithCredential(credientials);
                       print("phone login successful");
                       Navigator.of(context).pop();
                       if(loginStatus == "Login successfully as Doctor") {
                         showModalBottomSheet(
                             isDismissible: false, context: context, builder: (
                             ctx) {
                           return Container(
                             width: MediaQuery
                                 .of(context)
                                 .size
                                 .width,
                             height: MediaQuery
                                 .of(context)
                                 .size
                                 .height * 0.45,
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
                                       await FirebaseDatabase.getInstance.updateDoctorLiveStatus(email!, deviceToken, "live");
                                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                                         return DoctorProfile(email!);
                                       }));
                                     },
                                         child: Text("Yes")),
                                     SizedBox(width: 5,),
                                     ElevatedButton(onPressed: () async{
                                       await FirebaseDatabase.getInstance.updateDoctorLiveStatus(email!, "", "not live");
                                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                                         return DoctorProfile(email!);
                                       }));
                                     },
                                         child: Text("No")),
                                   ],
                                 )
                               ],
                             ),
                           );
                         });
                         return;
                       }
                       else if(loginStatus == "Login successfully as Patient"){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                           return TabsScreen(email!);
                         }));
                         return;
                       }
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successful")));
                       return;
                     }
                     on FirebaseAuthException catch(e){
                       print(e.message);
                       print(e.code);
                     }
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                   },
                   child: Container(
                       width: MediaQuery.of(context).size.width * 0.7,
                       height: 60,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: const Color(0xff0EBE7F)
                       ),
                       child: const Center(
                           child: Text("Continue",
                               style: TextStyle(color: Colors.white)
                           )
                       )
                   )
               )
             ],
           )
       ));
     },
         shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.only(
                 topRight: Radius.circular(60),
                 topLeft: Radius.circular(60)
             )
         ));
    }
    on PlatformException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _altSmsAutofill.unregisterListener();
    super.dispose();
  }
}