// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ShipmentItem extends StatelessWidget {
  const ShipmentItem({
    Key? key,
    required this.name,
    required this.weight,
    required this.emission,
    required this.status,
    required this.enroute_to,
  }) : super(key: key);

  final double weight;
  final double emission;
  final String name;
  final String status;
  final String enroute_to;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 15),
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color.fromARGB(255, 248, 248, 248),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, blurRadius: 2.0, offset: Offset(0.0, 2.0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 36.0,
            backgroundImage: NetworkImage(
              "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses-green-hair_23-2149436201.jpg?w=740&t=st=1660905781~exp=1660906381~hmac=7f04bebb70269c0dc8034da7a85c164b5004455b80ecf477e774d8f47cb8cd82",
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // "Hi, $name",
                  "$weight Kg | ${emission.toStringAsFixed(2)} kg CO\u2082",
                  style: GoogleFonts.openSans(
                      color: const Color(0xff464646),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  // place,
                  name,

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  // "Enroute CA, USA"
                  style: GoogleFonts.openSans(
                      color: const Color(0xff464646),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    const Icon(Icons.airport_shuttle_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      // place,
                      status == "TRAVEL"
                          ? "Enroute $enroute_to"
                          : status == "OUT FOR DELIVERY/DELIVERED"
                              ? "Delivered"
                              : "Processing",

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,

                      style: GoogleFonts.openSans(
                          color: const Color.fromARGB(255, 4, 67, 28),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
