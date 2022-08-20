// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih_frontend/screens/customerScreen/components/hero_dialog_route.dart';
import 'package:sih_frontend/screens/customerScreen/components/organisation_tile.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sih_frontend/utils/api_functions.dart';

import '../../model/product.dart';

// will use there productNameByBarcode and getProductFromBarcode
// Here is the rundown:
// scan barcode
// Call get productFromBarcode n display its shiz
// if not present,
// get productNameByBarcode n then display the name and category also (This will take 10 seconds)

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String barcode = "";
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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffECF0F1),
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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10),
                  child: Row(
                    children: [
                      Text(
                        "Good ${greeting()}!",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: "Lobster",
                        ),
                        // GoogleFonts.openSans(
                        //     fontSize: 28,
                        //     color: Color(0xff464646),
                        //     fontWeight: FontWeight.w600)
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () async {
                    String barcodeScanRes =
                        await FlutterBarcodeScanner.scanBarcode(
                            "#ff6666", 'Cancel', true, ScanMode.BARCODE);
                    debugPrint(barcodeScanRes);
                    debugPrint("above is gay");
                    // final x = await EcoTagAPI().getProductDetailsByBarcode(
                    //     barcode: barcodeScanRes.trim());
                    // print(x.toString());

                    if (barcodeScanRes.isNotEmpty && barcodeScanRes != "-1") {
                      Navigator.of(context).push(HeroDialogRoute(
                        builder: (context) {
                          return _ProductCard(
                            barcode: barcodeScanRes,
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

                      color: Color(0xffD2DFC8),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomLeft,
                      //   // Add one stop for each color. Stops should increase from 0 to 1
                      //   stops: const [0.1, 0.9],
                      //   colors: const [
                      //     Color.fromARGB(255, 0, 152, 155),
                      //     Color.fromARGB(255, 0, 94, 120),
                      //   ],
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          offset: Offset(0, 4), // changes position of shadow
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
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text("Recent Scans",
                          style: GoogleFonts.openSans(
                              fontSize: 24,
                              color: Color(0xff464646),
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Your previous scans will appear here");
                      }
                      SharedPreferences prefs =
                          snapshot.data! as SharedPreferences;
                      final String s = prefs.getString("scannedProducts") ?? "";
                      if (s == "") {
                        return Text("Your previous scans will appear here");
                      }
                      Map<String, dynamic> data = jsonDecode(s);
                      print(data.keys);
                      return ListView(
                          scrollDirection: Axis.horizontal,
                          children: data.keys.map((e) {
                            Product s = Product.fromJson(data[e]);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(HeroDialogRoute(
                                    builder: (context) {
                                      return _ProductCard(
                                        barcode: "",
                                        product: s,
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  height: 100,
                                  width: 90,
                                  child: CachedNetworkImage(
                                    imageUrl: s.image_url,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  // decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(30),
                                  //     image: DecorationImage(
                                  //         fit: BoxFit.fill,
                                  //         image:
                                  //             // AssetImage("assets/cotton.jpeg")
                                  //             )
                                  // ),
                                ),
                              ),
                            );
                          }).toList());
                    },
                  ),

                  // for (int i = 0; i < 5; i++)
                  //   Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       height: 100,
                  //       width: 90,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(30),
                  //           image: DecorationImage(
                  //               fit: BoxFit.fill,
                  //               image: AssetImage("assets/cotton.jpeg"))),
                  //     ),
                  //   ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Donate",
                              style: GoogleFonts.openSans(
                                  fontSize: 24,
                                  color: Color(0xff464646),
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w / 1.25,
                            child: AutoSizeText(
                                "Help companies take a cleaner and safer next step",
                                minFontSize: 11,
                                maxLines: 1,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Color(0xff464646),
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children:
                      [1, 2, 3, 4, 5].map((e) => OrganisationTile()).toList(),
                )
              ],
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
  const _ProductCard({super.key, required this.barcode, this.product = null});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            // color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: product != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 250,
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
                      ),
                    )
                  : FutureBuilder(
                      future: EcoTagAPI()
                          .getProductDetailsByBarcode(barcode: barcode.trim()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                child:
                                    Text('Could Not find Product in database'),
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
                            }
                          });
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 250,
                              child: Flex(
                                direction: Axis.vertical,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(a.name),
                                  CachedNetworkImage(
                                    imageUrl: a.image_url,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  RatingBarIndicator(
                                    rating: a.rating,
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
                            ),
                          );
                        }
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
