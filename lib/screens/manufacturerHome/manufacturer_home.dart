import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/x_not_used_color_container.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/monthly_stats.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/shipment_item.dart';

class ManufacturerHome extends StatefulWidget {
  const ManufacturerHome({super.key});

  @override
  State<ManufacturerHome> createState() => _ManufacturerHomeState();
}

class _ManufacturerHomeState extends State<ManufacturerHome> {
  var name = "User";
  var place = "Central Cambodia, Africa";
  @override
  Widget build(BuildContext context) {
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
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontFamily: "Lobster",
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            place,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(215, 48, 48, 47),
                              // fontFamily: "Acme",
                              fontWeight: FontWeight.w400,
                              // fontFamily: "OleoScript",
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 15),
                      const CircleAvatar(
                        radius: 36.0,
                        backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses-green-hair_23-2149436201.jpg?w=740&t=st=1660905781~exp=1660906381~hmac=7f04bebb70269c0dc8034da7a85c164b5004455b80ecf477e774d8f47cb8cd82",
                        ),
                      ),
                    ],
                  ),
                ),
                const MonthlyStat(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 2 * w / 5,
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0, 0.9],
                          colors: [
                            Color.fromARGB(255, 255, 101, 155),
                            Color.fromARGB(255, 254, 147, 177),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/cloud.png",
                                // color: Color.fromARGB(255, 0, 0, 0),
                                // width: 50.0,
                                // height: 50.0,
                              ),
                              const Text(
                                "High",
                                style: TextStyle(
                                    // color: Colors.white,
                                    fontFamily: "Acme",
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 194, 19, 19)),
                              ),
                            ],
                          ),
                          const Text(
                            "CO2 Emission",
                            style: TextStyle(
                                // color: Colors.white,
                                fontFamily: "Acme",
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Text(
                            "Improve now",
                            style: TextStyle(
                                // color: Colors.white,
                                // fontFamily: "Acme",
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 2 * w / 5,
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0.1, 0.95],
                          colors: [
                            Color.fromARGB(255, 199, 255, 233),
                            Color.fromARGB(255, 146, 222, 200),
                            // Color.fromARGB(255, 23, 183, 137),
                            // Color.fromARGB(255, 123, 230, 189),
                            // Color.fromARGB(255, 93, 182, 157),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/leaf.png",
                                // color: Color.fromARGB(255, 0, 0, 0),
                                // width: 50.0,
                                // height: 50.0,
                              ),
                              const Text(
                                "4.4",
                                style: TextStyle(
                                    // color: Colors.white,
                                    fontFamily: "Acme",
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 90, 167, 133)

                                    // color: Color.fromARGB(255, 0, 225, 128)
                                    ),
                              ),
                            ],
                          ),
                          const Text(
                            "Global Rating",
                            style: TextStyle(
                                // color: Colors.white,
                                fontFamily: "Acme",
                                fontSize: 20,
                                color: Color.fromARGB(255, 106, 188, 152)),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Text(
                            "Compare now",
                            style: TextStyle(
                                // color: Colors.white,
                                // fontFamily: "Acme",
                                fontSize: 15,
                                color: Color.fromARGB(255, 106, 188, 152)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                const Text(
                  "Your Shipments",
                  style: TextStyle(
                    fontFamily: "Acme",
                    fontSize: 28,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "In Transit",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(105, 0, 0, 0),
                        fontFamily: "Acme",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShipmentItem(),
                    ShipmentItem()
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Delivered",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(105, 0, 0, 0),
                        fontFamily: "Acme",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShipmentItem(),
                    ShipmentItem()
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
