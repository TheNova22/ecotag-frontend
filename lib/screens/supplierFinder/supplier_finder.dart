// ignore_for_file: prefer_const_constructors

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
                            hintText: "Try Mixed Fruit Jam",
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
                      ? Container()
                      : Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Text("Find the best suppliers",
                              style: GoogleFonts.openSans(
                                  fontSize: 28,
                                  color: Color(0xff464646),
                                  fontWeight: FontWeight.w300)),
                        )
                ],
              ),
            ),
          )),
    );
  }
}
