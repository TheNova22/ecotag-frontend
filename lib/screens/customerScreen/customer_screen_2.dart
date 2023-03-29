import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
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
    Map obj = await EcoTagAPI().detectImage(formData: formData);
    // print(response.data.runtimeType);
    return obj["object"];
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

  void findTip(BuildContext context) {
    final random = new Random();
    var i = random.nextInt(EcoTagAPI.tips.length);
    String tip = EcoTagAPI.tips[i];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: AutoSizeText(
              "Tip of the day",
              minFontSize: 8,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                  fontSize: 17, fontWeight: FontWeight.bold),
            ),
            content: AutoSizeText(
              tip,
              minFontSize: 8,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
          );
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
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.lightbulb,
                                    color: Colors.transparent),
                                onPressed: () {}),
                            Expanded(
                              child: Text("Ecotag Scanner",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                      fontSize: 30,
                                      color: Palette.primaryDarkGreen,
                                      fontWeight: FontWeight.bold)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final random = new Random();
                                var i = random.nextInt(EcoTagAPI.tips.length);
                                String tip = EcoTagAPI.tips[i];
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Tip of the Day"),
                                    content: Text(tip),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.white.withOpacity(0.7))),
                              child: Icon(Icons.lightbulb,
                                  color: Colors.black.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        const SizedBox(
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
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              // ignore: prefer_const_literals_to_create_immutables

                              color: Colors.white.withOpacity(0.6),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: const Offset(
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
                        const SizedBox(height: 25),
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
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      suffixIcon: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(15),
                                                    topRight:
                                                        const Radius.circular(
                                                            15))),
                                        child: IconButton(
                                            color: Colors.black,
                                            onPressed: () {},
                                            icon: const Icon(Icons.search)),
                                      ),
                                      hintText: "Search",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black54, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
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
                              const SizedBox(width: 5),
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
                                  icon: const Icon(Icons.camera_alt, size: 30),
                                  color: Palette.primaryDarkGreen),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    decoration: const BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(50),
                          topRight: const Radius.circular(50)),
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
                                icon: const Icon(Icons.delete),
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
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            height: 90,
                                            width: 90,
                                            padding: const EdgeInsets.all(20),
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
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                            );
                          },
                        ),
                        const SizedBox(
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
                        const SizedBox(height: 20),
                        Column(children: const [
                          OrganisationTile(
                            org_name: "CarbonFund.org",
                            org_desc:
                                "Reduce What You Can, Offset What You Can’t",
                            org_img_url: "",
                          ),
                          OrganisationTile(
                            org_name: "#TeamTrees",
                            org_desc:
                                "The team is growing every day and scoring wins for the planet. Plant with us and track our progress!",
                            org_img_url: "https://teamtrees.org/img/logo.png",
                          ),
                          OrganisationTile(
                            org_img_url:
                                "https://natureconservancy-h.assetsadobe.com/is/image/content/dam/tnc/nature/en/logos/TNC_Globe_square.png?crop=0%2C0%2C1102%2C826&wid=400&hei=300&scl=2.755",
                            org_desc:
                                "By maximizing our ability to effect change between now and 2030, we can shape a brighter future for people and our planet.",
                            org_name: "The Nature Conservancy",
                          ),
                          OrganisationTile(
                              org_desc:
                                  "As the leader in global conservation, WWF works in nearly 100 countries to make a difference for people and nature. Join our community.",
                              org_img_url:
                                  "https://upload.wikimedia.org/wikipedia/en/thumb/2/24/WWF_logo.svg/800px-WWF_logo.svg.png",
                              org_name: "World Wide Fund for Nature"),
                          OrganisationTile()
                        ])
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
  late Position _currentPosition;
  late String _currentAddress = "Assam";
  String materialType = "plastic";

  Map<String, int> prods = Map<String, int>();
  EcoTagAPI api = EcoTagAPI();

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);

  //     Placemark place = placemarks[0];

  //     setState(() {
  //       _currentAddress =
  //           "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //     print(_currentAddress);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  // await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.best,
  //         forceAndroidLocationManager: true)
  //     .then((Position position) {
  //   setState(() {
  //     _currentPosition = position;
  //     _getAddressFromLatLng();
  //   });
  // }).catchError((e) {
  //   print(e);
  // });
  // }

  List<Product> fin = [];

  Future<List<Product>> getrecommendations() async {
    List<String> cats = widget.product?.category ?? [];

    return await api.getProductsByCategory(categories: cats);
  }

  @override
  void initState() {
    super.initState();
    getrecommendations().then((arr) {
      Map<int, int> map = {};
      for (int i = 0; i < arr.length; i++) {
        int ct = 0;
        for (int j = 0; j < arr[i].category.length; j++) {
          if (widget.product!.category.contains(arr[i].category[j])) {
            ct += 1;
          }
        }
        if (ct > 0) map[i] = ct;
      }

      var sortedKeys = map.keys.toList(growable: false)
        ..sort((k1, k2) => map[k1]!.compareTo(map[k2]!));
      LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => map[k]);

      setState(() {
        fin = sortedMap.keys.map((e) => arr[e]).toList();
      });
    });

    //_getCurrentLocation();
    print("--------------------------------------------");
    print(_currentAddress);
  }

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;
  static const IconData leaf_2 =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  Widget build(BuildContext context) {
    double rating = 0.0;
    String ratingstr = widget.product?.rating.toStringAsFixed(2) ?? "0.0";
    double ratingDoub = double.parse(ratingstr);
    int rateint = ratingDoub.toInt();
    int ratingDec = (ratingDoub * 100).toInt();
    int dec = ratingDec - (rateint * 100);
    if (dec <= 25)
      rating = rateint.toDouble();
    else if (dec < 75)
      rating = rateint.toDouble() + 0.5;
    else
      rating = rateint.toDouble() + 1;

    print(widget.product);

    List<Widget> buildRecycleInfo(Product? product) {
      List<Widget> text = [];
      String mat = "paper";
      product!.rawMaterials.forEach((material) {
        if (EcoTagAPI.recycleMaterials.contains(material)) {
          text = EcoTagAPI.recycleMaterialsInfo[material]
              .map<Widget>(
                (info) => Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.recycling, color: Colors.green),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(info,
                            softWrap: true,
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              )
              .toList();
        }
      });
      return text;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: widget.product != null
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 20, right: 20, bottom: 20),
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
                          icon: const Icon(Icons.arrow_back, size: 30)),

                      Center(
                        child: AutoSizeText(
                          widget.product!.name,
                          minFontSize: 8,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              color: Palette.primaryDarkGreen,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Palette.secondaryGreen,
                            borderRadius: BorderRadius.circular(200),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.product!.image_url,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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
                      const SizedBox(height: 20),

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
                      const SizedBox(height: 15),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar(
                            itemSize: 30,
                            ignoreGestures: true,
                            initialRating: rating,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: const Icon(leaf_2, color: Colors.green),
                              half: HalfFilledIcon(
                                  icon: leaf_2, size: 20, color: Colors.green),
                              empty: const Icon(leaf_2, color: Colors.grey),
                            ),
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            onRatingUpdate: (rating) {},
                          ),
                          Container(
                            height: 30.0,
                            width: 2.0,
                            color: Colors.black,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          AutoSizeText(
                            rating.toString() + " / 5",
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

                      const SizedBox(height: 20),
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
                      const SizedBox(height: 15),
                      SizedBox(
                          height: 70,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: fin
                                  .map((e) => SimilarProduct(e.image_url))
                                  .toList())),
                      const SizedBox(height: 20),
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
                      SizedBox(height: 15),
                      Column(children: buildRecycleInfo(widget.product)),
                      SizedBox(height: 20),
                      AutoSizeText(
                        'Nearby Recyclers of ${materialType}:',
                        minFontSize: 15,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            color: Palette.forestGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // MapsLauncher.launchQuery(EcoTagAPI
                          //     .recyclingLocations["Assam"][materialType]);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                                EcoTagAPI.recyclingLocations[_currentAddress]
                                    [materialType][2],
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AutoSizeText(
                        'Nearby NGOs for ${materialType}:',
                        minFontSize: 15,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            color: Palette.forestGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          // MapsLauncher.launchQuery(
                          //     "Environmental Ngo's near me");
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: EcoTagAPI.silcharNGOS,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ]),
              )
            : FutureBuilder(
                future: EcoTagAPI()
                    .getProductDetailsByBarcode(barcode: widget.barcode.trim()),
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
                      debugPrint("hello i am nana$s");
                      if (s != "") data = jsonDecode(s);
                      if (!data.containsKey(a.name)) {
                        debugPrint("ADDING TO THE PREFS");
                        data.addEntries(
                            [MapEntry(a.name, a.toJson() as dynamic)]);
                        value.setString('scannedProducts', jsonEncode(data));
                        widget.statechange!(data);
                      }
                    });
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 20),
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
                                a.name,
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
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Palette.secondaryGreen,
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                padding: EdgeInsets.all(20),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: a.image_url,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
                                  initialRating: a.rating,
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
                                Container(
                                  height: 30.0,
                                  width: 2.0,
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                ),
                                AutoSizeText(
                                  a.rating.toStringAsFixed(2) + " / 5",
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
                                    children: fin
                                        .map((e) => SimilarProduct(e.image_url))
                                        .toList())),
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
                            SizedBox(height: 15),
                            Column(children: buildRecycleInfo(a)),
                            SizedBox(height: 20),
                            AutoSizeText(
                              'Nearby Recyclers of ${materialType}:',
                              minFontSize: 15,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  color: Palette.forestGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            // SizedBox(height: 15),
                            Container(
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                imageUrl: EcoTagAPI
                                        .recyclingLocations[_currentAddress]
                                    [materialType][2],
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            SizedBox(height: 20),
                            AutoSizeText(
                              'Nearby NGOs for ${materialType}:',
                              minFontSize: 15,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  color: Palette.forestGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            // SizedBox(height: 15),
                            Container(
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                imageUrl: EcoTagAPI
                                        .recyclingLocations[_currentAddress]
                                    [materialType][3],
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ]),
                    );
                  }
                },
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
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Palette.lightOcar,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.network(imageUrl, fit: BoxFit.cover)),
    );
  }
}
