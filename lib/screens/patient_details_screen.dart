import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(

            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image:  DecorationImage(image:  AssetImage("assets/images/Signup.png"), fit: BoxFit.cover,),
                      ),
                      child: Stack(
                        children: [

                          Positioned(
                            left: 15,
                            top: 55,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .4,
                              width: MediaQuery.of(context).size.width * .9,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Stack(

                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: ShapeDecoration(

                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  image: const DecorationImage(
                                                      image: AssetImage('assets/images/back.png')
                                                  )
                                              ),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 50,
                                    top: 5,
                                    child: Text(
                                      'Patient Details',
                                      style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 18,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.30,
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.270,
                            right: MediaQuery.of(context).size.width * 0.200,
                            top: 140,
                            child: Container(

                              width: MediaQuery.of(context).size.width * 90,
                              height: MediaQuery.of(context).size.height * .5,
                              child: Stack(


                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * .5,
                                      height: MediaQuery.of(context).size.width * .5,
                                      decoration: const ShapeDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/patient.png')
                                        ),
                                        color: Color(0xC1C6EFE5),
                                        shape: OvalBorder(
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 280.0),
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * .9,
                              child: const Text(
                                'Your cart is empty',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 22,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w700,

                                ),
                              ),
                            ),
                          ),



                          Positioned(
                            top: MediaQuery.of(context).size.height * .6,
                            left: MediaQuery.of(context).size.width * 0.150,
                            right: MediaQuery.of(context).size.width * 0.150,
                            child: Container(

                              width: MediaQuery.of(context).size.width * 50,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color(0xff00AC6E),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: const Center(
                                child: Text('Add Tests',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                  ),),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),



            ],

          ),
        )
    );
  }
}
