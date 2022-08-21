import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name =
        "Birdie Superfoods - 100% Pure A2 Gir Cow Ghee Through Vedic Bilona Method";
    double carbonEmission = 257;
    double rank = 3.4;
    double distance = 745;

    return Container(
      padding: EdgeInsets.only(bottom: 13),
      margin: EdgeInsets.only(top: 13),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Color.fromARGB(255, 113, 113, 113),
      ))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses-green-hair_23-2149436201.jpg?w=740&t=st=1660905781~exp=1660906381~hmac=7f04bebb70269c0dc8034da7a85c164b5004455b80ecf477e774d8f47cb8cd82",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                AutoSizeText(
                  name,
                  minFontSize: 9,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: Color(0xff464646),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        AutoSizeText(
                          carbonEmission.toString(),
                          minFontSize: 15,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Color.fromARGB(255, 166, 55, 55),
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "kg CO₂",
                          minFontSize: 7,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 10,
                              color: Color(0xff464646),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // rank
                    Column(
                      children: [
                        AutoSizeText(
                          rank.toString(),
                          minFontSize: 15,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Color.fromARGB(255, 166, 55, 55),
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "out of 5",
                          minFontSize: 7,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 10,
                              color: Color(0xff464646),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // kilometers
                    Column(
                      children: [
                        AutoSizeText(
                          distance.toString() + "k",
                          minFontSize: 15,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Color.fromARGB(255, 166, 55, 55),
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "Kilometers",
                          minFontSize: 7,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 10,
                              color: Color(0xff464646),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
