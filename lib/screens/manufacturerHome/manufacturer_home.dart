// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/x_not_used_color_container.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/monthly_stats.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/shipment_item.dart';
import 'package:sih_frontend/screens/settingsScreen/settings_screen.dart';

class ManufacturerHome extends StatefulWidget {
  const ManufacturerHome({super.key});

  @override
  State<ManufacturerHome> createState() => _ManufacturerHomeState();
}

class _ManufacturerHomeState extends State<ManufacturerHome>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var name = "User";
  var place = "Central Cambodia, Africa";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, $name",
                            style: GoogleFonts.openSans(
                                color: Color(0xff464646),
                                fontSize: 32,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Color.fromARGB(255, 219, 125, 118),
                                size: 24,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: w / 2.2,
                                child: AutoSizeText(
                                  place,
                                  minFontSize: 9,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.openSans(
                                      color: Color(0xff464646),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        child: const CircleAvatar(
                          radius: 36.0,
                          backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses-green-hair_23-2149436201.jpg?w=740&t=st=1660905781~exp=1660906381~hmac=7f04bebb70269c0dc8034da7a85c164b5004455b80ecf477e774d8f47cb8cd82",
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SettingsPage()));
                        },
                      ),
                    ],
                  ),
                ),
                const MonthlyStat(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 150,
                        width: 2.1 * w / 5,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                            )
                          ],
                          color: Color.fromARGB(255, 255, 165, 165),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/cloud.png",
                                    scale: 0.75,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "High",
                                    style: GoogleFonts.openSans(
                                        color: Color.fromARGB(255, 239, 33, 33),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "CO\u2082 Emission",
                              style: GoogleFonts.openSans(
                                  color: Color.fromARGB(255, 0, 93, 29),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "- Improve now",
                              style: GoogleFonts.openSans(
                                  color: Color.fromARGB(255, 0, 93, 29),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 2.1 * w / 5,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                            )
                          ],
                          color: Color.fromARGB(255, 201, 233, 193),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/leaf.png",
                                    scale: 0.65,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "4.45",
                                    style: GoogleFonts.openSans(
                                        color: Color.fromARGB(255, 2, 115, 49),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Global Rating",
                              style: GoogleFonts.openSans(
                                  color: Color.fromARGB(255, 0, 93, 29),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "- Compare now",
                              style: GoogleFonts.openSans(
                                  color: Color.fromARGB(255, 0, 93, 29),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Shipments",
                  style: GoogleFonts.openSans(
                      color: Color(0xff464646),
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "In Transit".toUpperCase(),
                  style: GoogleFonts.openSans(
                      color: Color(0xff464646),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShipmentItem(
                        name:
                            "Birdie Superfoods -100% Pure A2 Gir Cow Desi Ghee Through Vedic Bilona Method ",
                        weight: 25,
                        emission: 1456.4531441,
                        status: "TRAVEL",
                        enroute_to: "Hubli"),
                    ShipmentItem(
                        name:
                            "Birdie Superfoods -100% Pure A2 Gir Cow Desi Ghee Through Vedic Bilona Method ",
                        weight: 25,
                        emission: 1456.4531441,
                        status: "PROCESSING",
                        enroute_to: "-"),
                  ],
                ),
                Text(
                  "Delivered".toUpperCase(),
                  style: GoogleFonts.openSans(
                      color: Color(0xff464646),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShipmentItem(
                        name:
                            "Birdie Superfoods -100% Pure A2 Gir Cow Desi Ghee Through Vedic Bilona Method ",
                        weight: 25,
                        emission: 1456.4531441,
                        status: "OUT FOR DELIVERY/DELIVERED",
                        enroute_to: "Hubli"),
                    ShipmentItem(
                        name:
                            "Birdie Superfoods -100% Pure A2 Gir Cow Desi Ghee Through Vedic Bilona Method ",
                        weight: 25,
                        emission: 1456.4531441,
                        status: "OUT FOR DELIVERY/DELIVERED",
                        enroute_to: "Hubli"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
