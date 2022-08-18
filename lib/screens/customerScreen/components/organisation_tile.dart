// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganisationTile extends StatelessWidget {
  final String url;
  final String org_name, org_desc, org_img_url;
  const OrganisationTile(
      {Key? key,
      this.url = "",
      this.org_name = "",
      this.org_desc = "",
      this.org_img_url = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 20),
              width: w / 1.5,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CarbonFund.org",
                      style: GoogleFonts.openSans(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: w / 1.6,
                      child: AutoSizeText(
                        "Reduce What You Can, Offset What You Can’t",
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 11, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff94D0B3)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: Text(
                            "Donate",
                            style: GoogleFonts.openSans(
                                color: Color.fromARGB(255, 33, 33, 33),
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff94C5D0)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Color(0x94C5D0))))),
                          child: Text(
                            "Know more",
                            style: GoogleFonts.openSans(
                                color: Color.fromARGB(255, 33, 33, 33),
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: min(w / 4, 90),
              height: min(w / 4, 90),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage("assets/carbon.png"), fit: BoxFit.fill),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          color: Color(0xff9D9D9D),
          height: 1,
          width: w / 1.5,
        )
      ],
    );
  }
}
