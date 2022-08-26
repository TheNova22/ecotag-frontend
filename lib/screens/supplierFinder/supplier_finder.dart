// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/configs/palette.dart';
import 'package:sih_frontend/model/supplier.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';

class SupplierFinder extends StatefulWidget {
  const SupplierFinder({Key? key}) : super(key: key);

  @override
  State<SupplierFinder> createState() => _SupplierFinderState();
}

class _SupplierFinderState extends State<SupplierFinder> {
  bool searched = false;
  TextEditingController searchController = TextEditingController();
  List<Supplier> suppliers = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    Future getSuppliers() async {
      await EcoTagAPI()
          .getSupplierDetails(
              searchTerm: searchController.text.trim(),
              latitude: 130.56,
              longitude: 79.56)
          .then((value) {
        setState(() {
          searched = true;
          suppliers = value;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff464646),
        ),
      ),
      backgroundColor: Color(0xffECF0F1),
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                              controller: searchController,
                              cursorColor: Color.fromARGB(255, 152, 152, 152),
                              keyboardType: TextInputType.text,
                              onSubmitted: (val) {
                                getSuppliers();
                              },
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                suffixIcon: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.lightForestGreen,
                                      // color: Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  child: IconButton(
                                      color: Colors.black,
                                      onPressed: () {
                                        getSuppliers();
                                      },
                                      icon: Icon(Icons.search)),
                                ),
                                hintText: "Try raw cotton",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black54, width: 1.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  searched
                      ? Column(
                          children: suppliers
                              .map((e) => SupplierCard(supplier: e))
                              .toList(),
                        )
                      : Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text("Find the best suppliers",
                              style: GoogleFonts.openSans(
                                  fontSize: 25,
                                  color: Color(0xff464646),
                                  fontWeight: FontWeight.w300)),
                        ),
                ],
              ),
            ),
          )),
    );
  }
}

class SupplierCard extends StatelessWidget {
  const SupplierCard({Key? key, required this.supplier}) : super(key: key);
  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(color: Colors.white),
            height: 100,
            child: Row(
              children: [
                ClipRRect(
                    //borderRadius: BorderRadius.circular(25), // Image border
                    child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Color(0xffECF0F1),
                      image: DecorationImage(
                          image: NetworkImage(supplier.image_url),
                          fit: BoxFit.cover)),
                )
                    // SizedBox.fromSize(
                    //   size: Size.fromRadius(40), // Image radius
                    //   child: Image.network(supplier.image_url, fit: BoxFit.fill),
                    // ),
                    ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: w / 2,
                          child: AutoSizeText(
                            supplier.product_title,
                            minFontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: Color(0xff464646),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: w / 2,
                          child: AutoSizeText(
                            supplier.manufacturer_name,
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Color(0xff464646),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //margin: EdgeInsets.only(top: 2),
                                //width: w / 2,
                                child: AutoSizeText(
                                  supplier.manufacturer_address,
                                  minFontSize: 11,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 10,
                                      color: Color(0xff464646),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              AutoSizeText(
                                "Rs " + supplier.price,
                                minFontSize: 11,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    color: Color(0xff464646),
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 10, right: 5),
                //   width: 1,
                //   height: 75,
                //   color: Colors.grey,
                // ),
                // Icon(
                //   Icons.keyboard_arrow_right,
                //   size: 40,
                //   color: Color(0xff464646),
                // )
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 10),
          //   width: w / 1.2,
          //   color: Color.fromARGB(255, 209, 209, 209),
          //   height: 1,
          // )
        ],
      ),
    );
  }
}
