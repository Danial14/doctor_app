import 'package:flutter/material.dart';


class AllRecordScreen extends StatefulWidget {
  const AllRecordScreen({Key? key}) : super(key: key);

  @override
  State<AllRecordScreen> createState() => _AllRecordScreenState();
}

class _AllRecordScreenState extends State<AllRecordScreen> {
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
           width: MediaQuery.of(context).size.width * 90,
           decoration: const BoxDecoration(
            image:  DecorationImage(image:  AssetImage("assets/images/Signup.png"), fit: BoxFit.cover,),
          ),
        child: Stack (
      children: [

        Positioned(
          left: 15,
          top: 45,
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width * .8,
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
                    'All Records',
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


         Padding(
           padding: const EdgeInsets.only(left: 40,top: 85),

             child: SizedBox(
                 height: MediaQuery.of(context).size.height * .7,
                 width: MediaQuery.of(context).size.width * .8,
                 child: ListView.builder(
                     itemCount: 3,
                     itemBuilder: (context,index){
                    return Card(

                      child: Container(

                        height: 110,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 7,
                                height: 110,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 20,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14,
                              top: 80,
                              child: Container(
                                width: 55,
                                height: 22,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 55,
                                        height: 22,
                                        decoration: ShapeDecoration(
                                          color: const Color(0x190EBE7F),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                        ),
                                      ),
                                    ),
                                   const Positioned(
                                      left: 15,
                                      top: 5,
                                      child: SizedBox(
                                        width: 30,
                                        height: 20,
                                        child: Text(
                                          'NEW',
                                          style: TextStyle(
                                            color: Color(0xFF0EBE7F),
                                            fontSize: 12,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 81,
                              top: 26,
                              child: Container(
                                width: 155,
                                height: 61,
                                child: const Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Text(
                                        'Records added by you',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 22,
                                      child: Text(
                                        'Record for Abdullah mamun',
                                        style: TextStyle(
                                          color: Color(0xFF0EBE7F),
                                          fontSize: 12,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 1,
                                      top: 47,
                                      child: Text(
                                        '1 Prescription',
                                        style: TextStyle(
                                          color: Color(0xFF677294),
                                          fontSize: 12,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14,
                              top: 14,
                              child: Container(
                                width: 55,
                                height: 60,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 55,
                                        height: 60,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF0EBE7F),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        ),
                                      ),
                                    ),
                                   const Positioned(
                                      left: 14,
                                      top: 13,
                                      child: Text(
                                        '27\nFEB',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 321,
                              top: 10,
                              child: Container(
                                width: 4,
                                height: 20,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 4,
                                        height: 4,
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFF677294),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 8,
                                      child: Container(
                                        width: 4,
                                        height: 4,
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFF677294),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 16,
                                      child: Container(
                                        width: 4,
                                        height: 4,
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFF677294),
                                          shape: OvalBorder(),
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
                    );
                  }),
               ),
           ),




        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: (){},
              child: Container(
                width: MediaQuery.of(context).size.width * .7,
                height: 60,
                decoration: BoxDecoration(
                    color: const Color(0xff00AC6E),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: const Center(
                  child: Text('Add a record',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
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
      ),
    );
  }
}
