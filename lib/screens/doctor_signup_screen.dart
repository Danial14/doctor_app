import 'package:cliniconline/database/firebase/firebase_db.dart';
import 'package:cliniconline/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'option_screen.dart';

class DoctorSignupScreen extends StatefulWidget {
  const DoctorSignupScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSignupScreen> createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends State<DoctorSignupScreen> {
  final _formState = GlobalKey<FormState>();
  bool shouldPop = true;
  String _name ="";
  String _regNumber = "";
  String _emailAddress = "";
  String _password = "";
  String _phoneNumber = "";
  String _countryDialCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 1.3,
                  decoration: const BoxDecoration(
                    image:  DecorationImage(image:  AssetImage("assets/images/Signup.png"), fit: BoxFit.fill,),
                  ),
                ),
                SafeArea(child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .1 ,),
                    const Center(child: Text('Account Bana Kar Doctors se',style: TextStyle(
                      fontFamily: 'Rubik-Medium',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,

                    ),)),
                    const Center(child: Text('Hojaye Clinic Online',style: TextStyle(
                      fontFamily: 'Rubik-Medium',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),),),
                    const SizedBox(height: 10,),
                    const Center(child: Text('You can search course,apply course and find',style: TextStyle(
                      fontFamily: 'Rubik-Regular',
                      fontSize: 16,
                    ),),),
                    const Center(child: Text('scholarship for abroad studies',style: TextStyle(
                      fontFamily: 'Rubik-Regular',
                      fontSize: 16,
                    ),),),
                    const SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(

                            child: Align(
                              alignment: Alignment.center,
                              child: Card(

                                child:Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),


                                    width: MediaQuery.of(context).size.width * .4,
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/google3.png',height: 60,),
                                        const Text('Google',style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Rubik-Regular'
                                        ),)
                                      ],
                                    )
                                ),
                              ),
                            ),
                            onTap: (){
                              print('google');
                            },
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: (){
                              print('Facebook');
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Card(
                                child:Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),


                                    width: MediaQuery.of(context).size.width * .4,
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/facebook1.png',height: 60,),
                                        const Text('Facebook',style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Rubik-Regular'
                                        ),)
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Form(
                        key: _formState,
                        child:Column(
                          children: [
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,),
                              child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid username";
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                    _name = val!;
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(

                                    hintText: "Name",
                                    fillColor: const Color(0xffFFFFFF),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black26),
                                        borderRadius: BorderRadius.circular(15)
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black26
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,),
                              child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty || !val.contains('@')){
                                    return "Please provide valid Email";
                                  }
                                },
                                onSaved: (val){
                                  _emailAddress = val!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(

                                    hintText: "Email",
                                    fillColor: const Color(0xffFFFFFF),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black26),
                                        borderRadius: BorderRadius.circular(15)
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black26
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,),
                              child: TextFormField(
                                validator: (val){
                                  if(val!.length < 6){
                                    return "Please provide valid Password";
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                  _password = val!;
                                },
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(

                                    hintText: "Password",
                                    fillColor: const Color(0xffFFFFFF),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black26),
                                        borderRadius: BorderRadius.circular(15)
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black26
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 15,),
                              child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Please provide valid Registration Number";
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                    _regNumber = val!;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(

                                    hintText: "Registration Number",
                                    fillColor: const Color(0xffFFFFFF),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black26),
                                        borderRadius: BorderRadius.circular(15)
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black26
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const SizedBox(height: 20,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: IntlPhoneField(initialCountryCode: "PK"
                                ,decoration: InputDecoration(
                                    hintText: "Mobile Number",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
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
                                onCountryChanged: (country){
                                  print("Country name: ${country.name}");
                                  print("Country code: ${country.code}");
                                  print("Country dial code: ${country.dialCode}");
                                  print(country.maxLength);
                                  _countryDialCode = country.dialCode;
                                  _phoneNumber = _countryDialCode;
                                },
                                onSaved: (phoneNumber){
                                  print("OnSave");
                                  _phoneNumber = phoneNumber!.completeNumber;
                                },
                                validator: (phoneNumber){
                                  print("validator");
                                  _phoneNumber = phoneNumber!.completeNumber;
                                  if(!(phoneNumber!.isValidNumber())){
                                    return "Please enter valid phone number";
                                  }
                                },
                              ),
                            ),
                           /* RadioListTile(
                              title: const Text('I agree with the Terms of Services & Privacy Policy',style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Rubik-Regular'
                              ),),
                              fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                              value: 0,
                              onChanged: (Val){},
                              groupValue: 0,
                              toggleable: true,
                              selected: false,
                            )*/
                          ],
                        )

                    ),
                    const SizedBox(height: 5,),
                    InkWell(
                      onTap: (){
                        _Signup();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .7,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xff00AC6E),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(
                          child: Text('Sign Up',style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Rubik-Meduim',
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                        return EmailLoginScreen(true);
                      }));
                    },
                        child: const Text('Have an account? Log in',style: TextStyle(
                            fontFamily: 'Rubik-Regular',
                            fontSize: 16,
                            color: Color(0xff0EBE7F)
                        ),))
                  ],
                ),
                ),
              ],
            ),
          )

      );
  }
  void _Signup() async{
    var formstate = _formState.currentState!;
    bool isValid = formstate.validate();
    if (isValid) {
        formstate.save();
        FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance;
        String response = await firebaseDatabase.signUpWithCredientials(email: _emailAddress, password: _password, username: _name, registrationNo: _regNumber, mobileNo: _phoneNumber);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
        if(response == "Signup successful"){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
            return OptionScreen();
          }));
        }
      }
    if(_phoneNumber == _countryDialCode){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter valid Mobile number")));
    }
  }
}
