// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/supplier.dart';
import 'package:sih_frontend/utils/api_functions.dart';

class SupplierFinder extends StatefulWidget {
  SupplierFinder({Key? key}) : super(key: key);

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
    double h = MediaQuery.of(context).size.height;

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
                      Container(
                        height: 45.0,
                        width: w / 1.4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30.0),
                        child: TextField(
                          controller: searchController,
                          cursorColor: Color.fromARGB(255, 152, 152, 152),
                          keyboardType: TextInputType.text,
                          onSubmitted: (val) {
                            getSuppliers();
                          },
                          style: GoogleFonts.openSans(
                              color: Color(0xff464646),
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(22.0)),
                            // enabledBorder: const UnderlineInputBorder(
                            //     borderSide:
                            //         BorderSide(color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            border: const OutlineInputBorder(),
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                getSuppliers();
                              },
                            ),
                            hintText: "Try Raw Cotton",
                            hintStyle: const TextStyle(color: Colors.grey),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.filter_alt,
                        size: 45,
                        color: Color.fromARGB(255, 171, 171, 171),
                      )
                    ],
                  ),
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
                                  fontSize: 28,
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
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(25), // Image border
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Color(0xffECF0F1),
                          image: DecorationImage(
                              image: NetworkImage(supplier.image_url),
                              fit: BoxFit.fitWidth)),
                    )
                    // SizedBox.fromSize(
                    //   size: Size.fromRadius(40), // Image radius
                    //   child: Image.network(supplier.image_url, fit: BoxFit.fill),
                    // ),
                    ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: w / 2,
                      child: AutoSizeText(
                        supplier.product_title,
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 18,
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
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      width: w / 2,
                      child: AutoSizeText(
                        supplier.manufacturer_address,
                        minFontSize: 11,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontSize: 8,
                            color: Color(0xff464646),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 5),
                  width: 1,
                  height: 75,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 55,
                  color: Color(0xff464646),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: w / 1.2,
            color: Color.fromARGB(255, 209, 209, 209),
            height: 1,
          )
        ],
      ),
    );
  }
}
