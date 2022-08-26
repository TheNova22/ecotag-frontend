// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih_frontend/screens/manufacturerHome/manufacturer_home.dart';
import 'package:sih_frontend/screens/productsScreen/productsList.dart';
import 'package:sih_frontend/screens/reverseLogistics/reverse_logistics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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

  static const IconData youtube_searched_for =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dashboard =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData playlist_add =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  Future<String> getUser() async {
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;

    return auth.currentUser!.uid;
  }

  void getLoc() async {
    // ignore: unused_local_variable
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
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(dashboard, size: 28),
                activeIcon: Icon(dashboard, size: 30),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(playlist_add, size: 28),
                activeIcon: Icon(playlist_add, size: 30),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(youtube_searched_for, size: 28),
                activeIcon: Icon(youtube_searched_for, size: 30),
                label: "Home"),
          ],
          currentIndex: _selectedPageIndex,
          onTap: (selectedPageIndex) {
            setState(() {
              _selectedPageIndex = selectedPageIndex;
              _pageController.jumpToPage(selectedPageIndex);
            });
          },
        ));
  }
}
