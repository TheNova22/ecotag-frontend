// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih_frontend/configs/palette.dart';
import 'package:sih_frontend/screens/manufacturerHome/manufacturer_home_2.dart';
import 'package:sih_frontend/screens/productsScreen/productsList.dart';
import 'package:sih_frontend/screens/reverseLogistics/reverse_logistics.dart';
import 'package:sih_frontend/utils/api_functions.dart';
import 'package:sih_frontend/utils/globals.dart' as globals;
import 'package:sih_frontend/screens/supplierFinder/supplier_finder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPageIndex = 0;
  final List<Widget> _pages = [
    ManufacturerHome(),
    ProductsList(),
    ReverseLogisticsScreen(),
  ];
  late PageController _pageController;

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData youtube_searched_for = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dashboard = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData playlist_add = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  Future<String> getUser() async {
    await Firebase.initializeApp();

    FirebaseAuth auth = await FirebaseAuth.instance;

    return auth.currentUser!.uid;
  }

  void getLoc() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  void initState() {
    super.initState();

    // getUser().then((value) {
    //   globals.uid = value;

    //   EcoTagAPI().getManufacturer(mid: value).then((res) {
    //     globals.man = res;

    //     globals.found = true;

    //     debugPrint(res.toString());

    //     setState(() {});
    //   });
    // });

    getLoc();

    _selectedPageIndex = 0;

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BottomNavigationBar(
                    elevation: 10,
                    backgroundColor: Palette.dullGreen,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined,
                              size: 28, color: Colors.white),
                          activeIcon:
                              Icon(Icons.home, size: 28, color: Colors.white),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.work_outline_outlined,
                              size: 28, color: Colors.white),
                          activeIcon: Icon(Icons.work_rounded,
                              size: 28, color: Colors.white),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.widgets_outlined,
                              size: 28, color: Colors.white),
                          activeIcon: Icon(Icons.widgets_rounded,
                              size: 28, color: Colors.white),
                          label: "Home"),
                    ],
                    currentIndex: _selectedPageIndex,
                    onTap: (selectedPageIndex) {
                      setState(() {
                        _selectedPageIndex = selectedPageIndex;
                        _pageController.jumpToPage(selectedPageIndex);
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
