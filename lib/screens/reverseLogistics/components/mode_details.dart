// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sih_frontend/model/route.dart' as rt;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';

class ModeDetails extends StatelessWidget {
  const ModeDetails(
      {Key? key,
      required this.w,
      required this.selectedIndex,
      required this.res})
      : super(key: key);

  final double w;
  final int selectedIndex;
  final rt.Route res;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: min(w / 2.2, 200),
                height: min(w / 2.2, 200),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image:
                            AssetImage("assets/reverse/$selectedIndex.png"))),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: Color(0xff464646),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: w / 2.2,
                    child: AutoSizeText(
                      res.source,
                      minFontSize: 11,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Color(0xff464646),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "To",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: Color(0xff464646),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: w / 2.2,
                    child: AutoSizeText(
                      res.destination,
                      minFontSize: 11,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Color(0xff464646),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.eco,
                        color: Colors.green,
                        size: 30,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      AutoSizeText(
                        res.result[selectedIndex].emission.toStringAsFixed(2),
                        minFontSize: 11,
                        maxLines: 1,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: res.result[selectedIndex].emission > 75000.0
                                ? Color.fromARGB(255, 197, 15, 15)
                                : Color.fromARGB(255, 15, 197, 61),
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        " kg CO" "\u2082",
                        style: GoogleFonts.openSans(
                            fontSize: 13,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10),
          child: Row(
            children: [
              Text(
                "Pathway",
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    color: Color(0xff464646),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, top: 30, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  DotIndicator(
                    size: 30,
                    color: Color.fromARGB(255, 164, 219, 224),
                  ),
                  SizedBox(
                    height: 80.0,
                    width: 30,
                    child: DashedLineConnector(),
                  ),
                  DotIndicator(
                    size: 30,
                    color: Color.fromARGB(255, 164, 219, 224),
                  ),
                  SizedBox(
                    height: 80.0,
                    width: 30,
                    child: DashedLineConnector(),
                  ),
                  DotIndicator(
                    size: 30,
                    color: Color.fromARGB(255, 164, 219, 224),
                  ),
                  SizedBox(
                    height: 80.0,
                    width: 30,
                    child: DashedLineConnector(),
                  ),
                  DotIndicator(
                    size: 30,
                    color: Color.fromARGB(255, 164, 219, 224),
                  ),
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: SizedBox(
                      width: w / 1.8,
                      child: AutoSizeText(
                        res.source,
                        minFontSize: 11,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 21,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    child: SizedBox(
                      width: w / 1.8,
                      child: AutoSizeText(
                        "${res.result[selectedIndex].initalToPort1_distance.toStringAsFixed(2)} km \n${res.result[selectedIndex].initalToPort1_emission.toStringAsFixed(2)} kg CO\u2082",
                        minFontSize: 11,
                        maxLines: 2,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: SizedBox(
                      width: w / 1.8,
                      child: AutoSizeText(
                        res.result[selectedIndex].from,
                        minFontSize: 11,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 21,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    child: SizedBox(
                      width: w / 1.8,
                      child: AutoSizeText(
                        "${res.result[selectedIndex].port1ToPort2_distance.toStringAsFixed(2)} km \n${res.result[selectedIndex].port1ToPort2_emission.toStringAsFixed(2)} kg CO\u2082",
                        minFontSize: 11,
                        maxLines: 2,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: SizedBox(
                      width: w / 1.8,
                      child: AutoSizeText(
                        res.result[selectedIndex].to,
                        minFontSize: 11,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 21,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    child: SizedBox(
                      width: w / 1.8,
                      child: AutoSizeText(
                        "${res.result[selectedIndex].port2ToFinal_distance.toStringAsFixed(2)} km \n${res.result[selectedIndex].port2ToFinal_emission.toStringAsFixed(2)} kg CO\u2082",
                        minFontSize: 11,
                        maxLines: 2,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: SizedBox(
                      width: w / 1.8,
                      child: AutoSizeText(
                        res.destination,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 11,
                        maxLines: 1,
                        style: GoogleFonts.openSans(
                            fontSize: 21,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
