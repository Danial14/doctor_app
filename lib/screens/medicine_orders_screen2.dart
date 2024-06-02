import 'package:flutter/material.dart';

class MedicineOrderScreen2 extends StatefulWidget {
  const MedicineOrderScreen2({Key? key}) : super(key: key);

  @override
  State<MedicineOrderScreen2> createState() => _MedicineOrderScreen2State();
}

class _MedicineOrderScreen2State extends State<MedicineOrderScreen2> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Signup.png'),
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40.0,left: 20.0),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
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
                    const SizedBox(width: 20,),
                   const Text(
                      'Medicines orders',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 22,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),

                  child: TextFormField(

                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'search',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: (){
                          _searchController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      prefixIcon: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.search),
                      ),

                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: MediaQuery.of(context).size.height * .1,
                                  decoration:const  ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/guidemedicine.png'),


                                      ),
                                      shape: OvalBorder(),
                                      color: Color(0xC1C6EFE5)

                                  ),
                                ),
                              ),
                              const Text('Guide to medicine\norder',textAlign: TextAlign.center,style: TextStyle(
                                  fontFamily: 'Rubik-Medium',
                                  fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: MediaQuery.of(context).size.height * .1,
                                  decoration:const  ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/issue.png'),

                                      ),
                                      shape: OvalBorder(),
                                      color: Color(0xC1C6EFE5)

                                  ),
                                ),
                              ),

                              const Text('Prescription related\nissues',textAlign: TextAlign.center,style: TextStyle(
                                  fontFamily: 'Rubik-Medium',
                                  fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: MediaQuery.of(context).size.height * .1,
                                  decoration:const  ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/status.png'),

                                      ),
                                      shape: OvalBorder(),
                                      color: Color(0xC1C6EFE5)

                                  ),
                                ),
                              ),
                              const Text('Order status',style: TextStyle(
                                  fontFamily: 'Rubik-Medium',
                                  fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: MediaQuery.of(context).size.height * .1,
                                  decoration:const  ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/delivery.png'),

                                      ),
                                      shape: OvalBorder(),
                                      color: Color(0xC1C6EFE5)

                                  ),
                                ),
                              ),
                              const Text('Order delivery',style: TextStyle(
                                  fontFamily: 'Rubik-Medium',
                                  fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: MediaQuery.of(context).size.height * .1,
                                  decoration:const  ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/payment.png'),

                                      ),
                                      shape: OvalBorder(),
                                      color: Color(0xC1C6EFE5)

                                  ),
                                ),
                              ),
                              const Text('Payments & Refunds',style: TextStyle(
                                  fontFamily: 'Rubik-Medium',
                                  fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width * .4,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: MediaQuery.of(context).size.height * .1,
                                  decoration:const  ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/return.png'),

                                      ),
                                      shape: OvalBorder(),
                                      color: Color(0xC1C6EFE5)

                                  ),
                                ),
                              ),
                              const Text('Order returns',style: TextStyle(
                                  fontFamily: 'Rubik-Medium',
                                  fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
