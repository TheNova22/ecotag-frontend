import 'package:flutter/material.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/dropdown.dart';

class MonthlyStat extends StatefulWidget {
  const MonthlyStat({super.key});

  @override
  State<MonthlyStat> createState() => _MonthlyStatState();
}

class _MonthlyStatState extends State<MonthlyStat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      // height: 500,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.16),
          )
        ],
        //color: Palette.lightPurple,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          // stops: [0.1, 0.9],
          colors: [
            Color.fromARGB(255, 160, 226, 244),
            Color.fromARGB(255, 110, 149, 227),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Monthly Statistics",
                style: TextStyle(
                    color: Colors.white, fontSize: 24, fontFamily: "Acme"),
              ),
              DropDown()
              // Text(
              //   "Aug",
              //   style: TextStyle(
              //       color: Colors.white, fontSize: 16, fontFamily: "Acme"),
              // )
            ],
          ),
          const Divider(
            height: 40,
            thickness: 2,
            indent: 15,
            endIndent: 0,
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.lightBlueAccent,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Shipments",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          // fontFamily: "Acme"
                        ),
                      ),
                      Text(
                        "4564 u",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: "Acme"),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Distance Covered",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          // fontFamily: "Acme"
                        ),
                      ),
                      Text(
                        "256k km",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: "Acme"),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
