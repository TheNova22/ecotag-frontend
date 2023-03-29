// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
          color: Color(0xfff1f1e7),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            org_name,
                            style: GoogleFonts.openSans(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            width: w / 1.6,
                            child: AutoSizeText(
                              org_desc,
                              minFontSize: 8,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xffbfac5d),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Text(
                            "Donate",
                            style: GoogleFonts.openSans(
                                color: Color.fromARGB(255, 33, 33, 33),
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: min(w / 3.5, 100),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      image: org_img_url == ""
                          ? DecorationImage(
                              image: AssetImage("assets/logo.png"),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                org_img_url,
                              )),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
