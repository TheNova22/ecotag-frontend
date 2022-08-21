// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sih_frontend/screens/manufacturerHome/manufacturer_home.dart';
import 'package:sih_frontend/screens/productsScreen/productsList.dart';
import 'package:sih_frontend/screens/reverseLogistics/reverse_logistics.dart';
import 'package:sih_frontend/screens/supplierFinder/supplier_finder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPageIndex = 0;
  List<Widget> _pages = [
    ManufacturerHome(),
    ProductsList(),
    ReverseLogisticsScreen(),
  ];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

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
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 28),
                activeIcon: Icon(Icons.home, size: 28),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.work_outline_outlined, size: 28),
                activeIcon: Icon(Icons.work_rounded, size: 28),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.widgets_outlined, size: 28),
                activeIcon: Icon(Icons.widgets_rounded, size: 28),
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
