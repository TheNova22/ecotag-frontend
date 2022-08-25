import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/product.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 13),
      margin: const EdgeInsets.only(top: 13),
      decoration: const BoxDecoration(
          border: Border(
              bottom: const BorderSide(
        color: Color.fromARGB(255, 113, 113, 113),
      ))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(product.image_url),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                AutoSizeText(
                  product.name,
                  minFontSize: 9,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: const Color(0xff464646),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        AutoSizeText(
                          product.totalEmission.toStringAsFixed(2),
                          minFontSize: 15,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: product.totalEmission > 750
                                  ? const Color.fromARGB(255, 166, 55, 55)
                                  : const Color.fromARGB(255, 5, 120, 60),
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "kg CO₂",
                          minFontSize: 7,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 10,
                              color: const Color(0xff464646),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // rank
                    Column(
                      children: [
                        AutoSizeText(
                          product.rating.toStringAsFixed(2),
                          minFontSize: 15,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: product.rating < 2.5
                                  ? const Color.fromARGB(255, 166, 55, 55)
                                  : const Color.fromARGB(255, 5, 120, 60),
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "out of 5",
                          minFontSize: 7,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 10,
                              color: const Color(0xff464646),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // kilometers
                    Column(
                      children: [
                        AutoSizeText(
                          product.totalManufacturers.toString(),
                          minFontSize: 15,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: product.totalManufacturers < 3
                                  ? const Color.fromARGB(255, 166, 55, 55)
                                  : const Color.fromARGB(255, 5, 120, 60),
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "Manufacturers",
                          minFontSize: 7,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 10,
                              color: const Color(0xff464646),
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
