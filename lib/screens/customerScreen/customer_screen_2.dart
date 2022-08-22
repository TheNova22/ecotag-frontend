// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih_frontend/configs/palette.dart';
import 'package:sih_frontend/screens/customerScreen/components/hero_dialog_route_2.dart';
import 'package:sih_frontend/screens/customerScreen/components/organisation_tile_2.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sih_frontend/utils/api_functions.dart';

import '../../model/product.dart';

// will use there productNameByBarcode and getProductFromBarcode
// Here is the rundown:
// scan barcode
// Call get productFromBarcode n display its shiz
// if not present,
// get productNameByBarcode n then display the name and category also (This will take 10 seconds)

class CustomerScreen2 extends StatefulWidget {
  CustomerScreen2({Key? key}) : super(key: key);

  @override
  State<CustomerScreen2> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen2> {
  String barcode = "";
  Map<String, dynamic> data = {};
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  void statechangeFunction(Map<String, dynamic> d) {
    setState(() {
      data = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.primaryGreen,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text("Ecotag Scanner",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  fontSize: 30,
                                  color: Palette.primaryDarkGreen,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () async {
                            String barcodeScanRes =
                                await FlutterBarcodeScanner.scanBarcode(
                                    "#ff6666",
                                    'Cancel',
                                    true,
                                    ScanMode.BARCODE);
                            debugPrint(barcodeScanRes);
                            debugPrint("above is gay");
                            // final x = await EcoTagAPI().getProductDetailsByBarcode(
                            //     barcode: barcodeScanRes.trim());
                            // print(x.toString());

                            if (barcodeScanRes.isNotEmpty &&
                                barcodeScanRes != "-1") {
                              Navigator.of(context).push(HeroDialogRoute(
                                builder: (context) {
                                  return _ProductCard(
                                    barcode: barcodeScanRes,
                                    statechange: statechangeFunction,
                                    // product: null,
                                  );
                                },
                              ));
                            }
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              // ignore: prefer_const_literals_to_create_immutables

                              color: Colors.white.withOpacity(0.6),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/barcode.png",
                              width: 100,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recent Scans",
                                style: GoogleFonts.openSans(
                                    fontSize: 24,
                                    color: Palette.primaryDarkGreen,
                                    fontWeight: FontWeight.w600)),
                            IconButton(
                                onPressed: () async {
                                  await SharedPreferences.getInstance()
                                      .then((value) => value.clear());
                                  setState(() {
                                    data = {};
                                  });
                                },
                                icon: Icon(Icons.delete),
                                color: Palette.primaryDarkGreen),
                          ],
                        ),
                        FutureBuilder(
                          future: SharedPreferences.getInstance(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return SizedBox(
                                height: 30,
                                child: AutoSizeText(
                                  "Your previous scans will appear here",
                                  minFontSize: 8,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }
                            SharedPreferences prefs =
                                snapshot.data! as SharedPreferences;
                            final String s =
                                prefs.getString("scannedProducts") ?? "";
                            if (s == "") {
                              return SizedBox(
                                height: 30,
                                child: AutoSizeText(
                                  "Your previous scans will appear here",
                                  minFontSize: 8,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }
                            data = jsonDecode(s);

                            return SizedBox(
                              height: 100,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: data.keys.map((e) {
                                    Product s = Product.fromJson(data[e]);
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(HeroDialogRoute(
                                          builder: (context) {
                                            return _ProductCard(
                                              barcode: "",
                                              product: s,
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            height: 90,
                                            width: 90,
                                            padding: EdgeInsets.all(20),
                                            //margin: EdgeInsets.only(right: 15),
                                            decoration: BoxDecoration(
                                              color: Palette.lightOcar,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              // border: Border.all(
                                              //     color:
                                              //         Palette.primaryDarkGreen)
                                              // border: BoxBorder()
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: s.image_url,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text("Donate",
                                    style: GoogleFonts.openSans(
                                        fontSize: 24,
                                        color: Palette.primaryDarkGreen,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: w / 1.25,
                                    child: AutoSizeText(
                                      "Help companies take a cleaner and safer next step",
                                      minFontSize: 8,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [1, 2, 3, 4, 5]
                              .map((e) => OrganisationTile())
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class _ProductCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  final String barcode;
  final Product? product;
  final Function? statechange;
  const _ProductCard(
      {super.key, required this.barcode, this.product, this.statechange});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: _heroAddTodo,
        child: Material(
          // color: Colors.white,
          color: Palette.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: product != null
                ? SizedBox(
                    height: 400,
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(product!.name),
                        CachedNetworkImage(
                          imageUrl: product!.image_url,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        RatingBarIndicator(
                          rating: product!.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          itemCount: 5,
                          itemSize: 50.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  )
                : FutureBuilder(
                    future: EcoTagAPI()
                        .getProductDetailsByBarcode(barcode: barcode.trim()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Column(
                          children: const [
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ));
                      }
                      if (snapshot.error != null) {
                        debugPrint(snapshot.error.toString());
                        return Column(
                          children: const [
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Text('Could Not find Product in database'),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        );
                      } else {
                        final Product a = snapshot.data as Product;
                        SharedPreferences.getInstance().then((value) {
                          Map<String, dynamic> data = {};

                          final s = value.getString("scannedProducts") ?? "";
                          print("hello i am nana" + s);
                          if (s != "") data = jsonDecode(s);
                          if (!data.containsKey(a.name)) {
                            print("ADDING TO THE PREFS");
                            data.addEntries(
                                [MapEntry(a.name, a.toJson() as dynamic)]);
                            value.setString(
                                'scannedProducts', jsonEncode(data));
                            statechange!(data);
                          }
                        });
                        return Container(
                          padding: EdgeInsets.all(25),
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //Text(a.name),
                              AutoSizeText(
                                a.name,
                                minFontSize: 8,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    color: Palette.primaryDarkGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: CachedNetworkImage(
                                  imageUrl: a.image_url,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                "Ecotag rating: " + a.rating.toString() + "/5",
                                minFontSize: 8,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    color: Palette.primaryDarkGreen,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              RatingBarIndicator(
                                rating: a.rating,
                                unratedColor:
                                    Color.fromARGB(255, 204, 206, 209),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Color(0xffba0c822),
                                  //color: Color(0xff8bbb87),
                                ),
                                itemCount: 5,
                                itemSize: 40.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
