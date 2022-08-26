// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, unused_element

import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih_frontend/configs/palette.dart';
import 'package:sih_frontend/screens/customerScreen/components/half_filled_icon.dart';
import 'package:sih_frontend/screens/customerScreen/components/hero_dialog_route_2.dart';
import 'package:sih_frontend/screens/customerScreen/components/organisation_tile_2.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sih_frontend/screens/customerScreen/searchProductScreen/search_products_screen.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';

import '../../model/product.dart';

// will use there productNameByBarcode and getProductFromBarcode
// Here is the rundown:
// scan barcode
// Call get productFromBarcode n display its shiz
// if not present,
// get productNameByBarcode n then display the name and category also (This will take 10 seconds)

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String barcode = "";
  Map<String, dynamic> data = {};

  Future<String> req(String path) async {
    // path = value.path;
    var formData = FormData();
    formData.files.add(MapEntry(
      "Picture",
      await MultipartFile.fromFile(path, filename: "pic-name.png"),
    ));
    String val = "";
    await Dio()
        .post('http://cantin.centralindia.cloudapp.azure.com/detectImage',
            data: formData)
        .then((value) {
      debugPrint(value.toString());
      val = value.data["object"];
    });
    debugPrint("1");
    debugPrint(val);
    return val;
    // print(response.data.runtimeType);
  }

  Future<String> _getImage() async {
    String res = "";
    final ImagePicker picker = ImagePicker();
    var image =
        await picker.pickImage(source: ImageSource.camera).then((value) async {
      await req(value!.path).then((value) {
        res = value;
      });
    });

    return res;
  }

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
                        SizedBox(
                          width: double.infinity,
                          child: Text("Ecotag Scanner",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  fontSize: 30,
                                  color: Palette.primaryDarkGreen,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 25,
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
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                    onSubmitted: (String val) {
                                      debugPrint(val);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SearchProducts(
                                                      searchTerm: val)));
                                    },
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      suffixIcon: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15),
                                                topRight: Radius.circular(15))),
                                        child: IconButton(
                                            color: Colors.black,
                                            onPressed: () {},
                                            icon: Icon(Icons.search)),
                                      ),
                                      hintText: "Search",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black54, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black54,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      // focusedBorder: OutlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         color: Colors.black, width: 32.0),
                                      //     borderRadius:
                                      //         BorderRadius.circular(15.0))
                                    )),
                                // child: TextField(
                                //     keyboardType: TextInputType.text,
                                //     onSubmitted: (String val) {
                                //       print(val);
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (BuildContext context) =>
                                //                   SearchProducts(
                                //                       searchTerm: val)));
                                //     },
                                //     style: TextStyle(
                                //       fontSize: 15.0,
                                //       color: Colors.black,
                                //     ),
                                //     decoration: InputDecoration(
                                //       contentPadding: EdgeInsets.fromLTRB(
                                //           20.0, 15.0, 20.0, 15.0),
                                //       suffixIcon: IconButton(
                                //           onPressed: () {},
                                //           icon: Icon(Icons.search)),
                                //       hintText: "Search",
                                //       border: OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //               color: Colors.black, width: 32.0),
                                //           borderRadius:
                                //               BorderRadius.circular(15.0)),
                                //     )),
                              ),
                              SizedBox(width: 5),
                              IconButton(
                                  onPressed: () {
                                    _getImage().then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SearchProducts(
                                                      searchTerm: value)));
                                    });
                                  },
                                  icon: Icon(Icons.camera_alt, size: 30),
                                  color: Palette.primaryDarkGreen),
                            ],
                          ),
                        ),
                      ],
                    ),
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
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;
  static const IconData leaf =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData leaf_2 =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData leaf_1 =
      IconData(0xe849, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData zigzag_leaf =
      IconData(0xeaee, fontFamily: _kFontFam, fontPackage: _kFontPkg);


class _ProductCard extends StatefulWidget {

  /// {@macro add_todo_popup_card}
  final String barcode;
  final Product? product;
  final Function? statechange;
  const _ProductCard(
      {super.key, required this.barcode, this.product, this.statechange});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  Map<String, int> prods = Map<String, int>();
  EcoTagAPI api = EcoTagAPI();

  List<Product> fin = [];

  Future<List<Product>> getrecommendations() async {
    List<String> cats = widget.product!.category;

    return await api.getProductsByCategory(categories: cats);
  }

  @override
  void initState() {
    super.initState();
    // getrecommendations().then((arr) {
    //   Map<int, int> map = {};
    //   for (int i = 0; i < arr.length; i++) {
    //     int ct = 0;
    //     for (int j = 0; j < arr[i].category.length; j++) {
    //       if
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    print(product);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            // -----------------------------------------------------------------------
            // color: Colors.white,
            color: Palette.white,
              child: product != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 20),
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          //padding: EdgeInsets.all(25),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Text(a.name),

                                IconButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.arrow_back, size: 30)),

                                Center(
                                  child: AutoSizeText(
                                    product!.name,
                                    minFontSize: 8,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                        color: Palette.primaryDarkGreen,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                      color: Palette.secondaryGreen,
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: product!.image_url,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 20),
                                // AutoSizeText(
                                //   "Categories: " +
                                //       product!.category.reduce(
                                //           (value, element) =>
                                //               element = value + ", " + element),
                                //   minFontSize: 8,
                                //   maxLines: 3,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: GoogleFonts.openSans(
                                //       color: Palette.primaryDarkGreen,
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w500),
                                // ),
                                SizedBox(height: 20),

                                AutoSizeText(
                                  "EcoTag rating: ",
                                  minFontSize: 15,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      color: Palette.forestGreen,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 15),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar(
                                      itemSize: 30,
                                      ignoreGestures: true,
                                      initialRating: product!.rating,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                        full: Icon(leaf_2, color: Colors.green),
                                        half: HalfFilledIcon(
                                            icon: leaf_2,
                                            size: 20,
                                            color: Colors.green),
                                        empty: Icon(leaf_2, color: Colors.grey),
                                      ),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    SizedBox(width: 10),
                                    AutoSizeText(
                                      "( " +
                                          product!.rating.toString() +
                                          "/5 )",
                                      minFontSize: 15,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          color: Palette.forestGreen,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),
                                AutoSizeText(
                                  "Similar Products:",
                                  minFontSize: 15,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      color: Palette.forestGreen,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 15),
                                SizedBox(
                                    height: 70,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          SimilarProduct(),
                                          SimilarProduct(),
                                          SimilarProduct(),
                                          SimilarProduct(),
                                        ])),

                                SizedBox(height: 20),
                                AutoSizeText(
                                  "How to recycle this product? ",
                                  minFontSize: 15,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      color: Palette.forestGreen,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     InkWell(
                                //       onTap: () {},
                                //       child: Container(
                                //         padding: EdgeInsets.symmetric(
                                //             horizontal: 10, vertical: 5),
                                //         decoration: BoxDecoration(
                                //             color: Palette.primaryOcar,
                                //             borderRadius:
                                //                 BorderRadius.circular(15)),
                                //         child: Row(
                                //           children: [
                                //             Icon(Icons.location_pin, size: 25),
                                //             SizedBox(width: 5),
                                //             Text("Nearby Suppliers")
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ])),
                    )

              child: widget.product != null
                  ? Container(
                      padding: EdgeInsets.all(25),
                      child: Flex(
                          direction: Axis.vertical,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //Text(a.name),
                            AutoSizeText(
                              widget.product!.name,
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
                              height: 150,
                              child: CachedNetworkImage(
                                imageUrl: widget.product!.image_url,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            SizedBox(height: 20),
                            AutoSizeText(
                              "Categories: ${widget.product!.category.reduce((value, element) => element = "$value, $element")}",
                              minFontSize: 8,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  color: Palette.primaryDarkGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),
                            AutoSizeText(
                              "Ecotag rating: ${widget.product!.rating}/5",
                              minFontSize: 8,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  color: Palette.primaryDarkGreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            RatingBarIndicator(
                              rating: widget.product!.rating,
                              unratedColor: Color.fromARGB(255, 204, 206, 209),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Color(0xffba0c822),
                                //color: Color(0xff8bbb87),
                              ),
                              itemCount: 5,
                              itemSize: 40.0,
                              direction: Axis.horizontal,
                            ),

                            SizedBox(height: 20),
                            AutoSizeText(
                              "Similar Products:",
                              minFontSize: 8,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  color: Palette.primaryDarkGreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                                height: 70,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: fin
                                        .map((e) => SimilarProduct(e.image_url))
                                        .toList())),
                          ]))

                  : FutureBuilder(
                      future: EcoTagAPI().getProductDetailsByBarcode(
                          barcode: widget.barcode.trim()),
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
                            debugPrint("hello i am nana$s");
                            if (s != "") data = jsonDecode(s);
                            if (!data.containsKey(a.name)) {
                              debugPrint("ADDING TO THE PREFS");
                              data.addEntries(
                                  [MapEntry(a.name, a.toJson() as dynamic)]);
                              value.setString(
                                  'scannedProducts', jsonEncode(data));
                              widget.statechange!(data);
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
                                      height: 150,
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
                                      "Categories: ${a.category.reduce((value, element) => element = "$value, $element")}",
                                      minFontSize: 8,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          color: Palette.primaryDarkGreen,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 20),
                                    AutoSizeText(
                                      "Ecotag rating: ${a.rating}/5",
                                      minFontSize: 8,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          color: Palette.primaryDarkGreen,
                                          fontSize: 15,
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

                                    SizedBox(height: 20),
                                    AutoSizeText(
                                      "Similar Products:",
                                      minFontSize: 8,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          color: Palette.primaryDarkGreen,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                        height: 70,
                                        child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: fin
                                                .map((e) =>
                                                    SimilarProduct(e.image_url))
                                                .toList())),
                                  ]));
                        }
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget SimilarProduct(String imageUrl) {
    return InkWell(
      onTap: () {},
      child: Container(
          //height: 40,
          width: 70,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Palette.lightOcar,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.network(imageUrl, fit: BoxFit.cover)),
    );
  }
}