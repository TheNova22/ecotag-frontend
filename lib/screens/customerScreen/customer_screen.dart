// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/result.dart';
import 'package:sih_frontend/model/route.dart' as rt;
import 'package:sih_frontend/screens/customerScreen/components/organisation_tile.dart';
import 'package:sih_frontend/screens/reverseLogistics/components/custom_tfield.dart';
import 'package:sih_frontend/screens/reverseLogistics/components/mode_details.dart';
import 'package:sih_frontend/utils/api_functions.dart';
import 'package:timelines/timelines.dart';

// will use there productNameByBarcode and getProductFromBarcode
// Here is the rundown:
// scan barcode
// Call get productFromBarcode n display its shiz
// if not present,
// get productNameByBarcode n then display the name and category also (This will take 10 seconds)

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool searched = false;
  rt.Route res =
      rt.Route.fromMap({"source": "", "destination": "", "result": []});
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Future getModes() async {
      await EcoTagAPI()
          .getAllRoutes(
              fromAddress: fromController.text.trim(),
              toAddress: toController.text.trim())
          .then((value) {
        setState(() {
          res = value;
          searched = true;
        });
      });
    }

    return Scaffold(
      backgroundColor: Color(0xffECF0F1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff464646),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10),
                child: Row(
                  children: [
                    Text("Good morning!",
                        style: GoogleFonts.openSans(
                            fontSize: 28,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Color.fromARGB(47, 91, 208, 2)),
                  ),
                  SizedBox(
                      width: 200,
                      height: 100,
                      child: Image.asset('assets/barcode.png'))
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("Recent Scans",
                        style: GoogleFonts.openSans(
                            fontSize: 24,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 100,
                    ),
                    for (int i = 0; i < 5; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/cotton.jpeg"))),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Donate",
                            style: GoogleFonts.openSans(
                                fontSize: 20,
                                color: Color(0xff464646),
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            "Help companies take a cleaner and safer next step",
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Color(0xff464646),
                                fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: 200,
                  child: ListView(
                    children: [for (int i = 0; i < 5; i++) OrganisationTile()],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
