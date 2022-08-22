// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/result.dart';
import 'package:sih_frontend/model/route.dart' as rt;
import 'package:sih_frontend/screens/reverseLogistics/components/custom_tfield.dart';
import 'package:sih_frontend/screens/reverseLogistics/components/mode_details.dart';
import 'package:sih_frontend/screens/supplierFinder/supplier_finder.dart';
import 'package:sih_frontend/utils/api_functions.dart';
import 'package:timelines/timelines.dart';

class ReverseLogisticsScreen extends StatefulWidget {
  ReverseLogisticsScreen({Key? key}) : super(key: key);

  @override
  State<ReverseLogisticsScreen> createState() => _ReverseLogisticsScreenState();
}

class _ReverseLogisticsScreenState extends State<ReverseLogisticsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool searched = false;
  rt.Route res =
      rt.Route.fromMap({"source": "", "destination": "", "result": []});
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffECF0F1),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 188, 233, 239),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SupplierFinder()));
          },
          child: Icon(
            Icons.search,
            size: 32,
            color: Colors.deepOrangeAccent,
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Row(
                      children: [
                        Text("Return Emissions",
                            style: GoogleFonts.openSans(
                                fontSize: 28,
                                color: Color(0xff464646),
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 5),
                    child: Row(
                      children: [
                        Text("Emission from all modes of transport",
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Color(0xff464646),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                      controller: fromController,
                      title: "From",
                      hint: "Sender's Address",
                      prefixIcon: Icons.my_location,
                      width: w / 1.5,
                      height: 60),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      controller: toController,
                      title: "To",
                      hint: "Your Address",
                      prefixIcon: Icons.share_location,
                      width: w / 1.5,
                      height: 60),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 213, 238, 201),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                            )
                          ]),
                      child: IconButton(
                          iconSize: 40,
                          onPressed: () {
                            getModes();
                          },
                          icon: Icon(
                            Icons.query_stats,
                            color: Color(0xff464646),
                          ))),
                  searched
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 1,
                          width: w / 1.2,
                          color: Color.fromARGB(255, 201, 201, 201),
                        )
                      : Container(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          [0, "Airways"],
                          [1, "Waterways"],
                          [2, "Railways"],
                          [3, "Roadways"],
                        ]
                            .map<Widget>((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex =
                                            int.parse(e[0].toString());
                                      });
                                    },
                                    style: (selectedIndex == e[0])
                                        ? ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Color.fromARGB(
                                                        255, 52, 156, 120)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Colors.blueAccent))))
                                        : ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 191, 216, 207)),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                    child: Text(
                                      e[1].toString(),
                                      style: (selectedIndex == e[0])
                                          ? GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 232, 232, 232),
                                              fontWeight: FontWeight.w700)
                                          : GoogleFonts.openSans(
                                              fontSize: 15,
                                              color: Color(0xff464646),
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  (searched)
                      ? SizedBox(
                          height: 20,
                        )
                      : Container(),
                  (searched)
                      ? ModeDetails(
                          w: w, selectedIndex: selectedIndex, res: res)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
