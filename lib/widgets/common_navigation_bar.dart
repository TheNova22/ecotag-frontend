// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:sih_frontend/configs/palette.dart';
// import 'package:sih_frontend/screens/manufacturerHome/manufacturer_home.dart';
// import 'package:sih_frontend/screens/productsScreen/productsList.dart';

// // Widget CommonBottomNavigationBar(int page, BuildContext context) {
// //   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
// //   return CurvedNavigationBar(
// //     key: _bottomNavigationKey,
// //     index: page,
// //     height: 60.0,
// //     items: const <Widget>[
// //       Icon(Icons.home_filled, color: Palette.white, size: 30),
// //       Icon(Icons.wallet_travel, color: Palette.white, size: 30),
// //       Icon(Icons.account_circle_sharp, color: Palette.white, size: 30),
// //     ],
// //     color: Palette.blue,
// //     buttonBackgroundColor: Palette.blue,
// //     backgroundColor: Colors.white,
// //     animationCurve: Curves.easeInOut,
// //     animationDuration: const Duration(milliseconds: 600),
// //     onTap: (index) {
// //       page = index;
// //       switch (index) {
// //         case 0:
// //           Navigator.of(context).pushReplacement(
// //               MaterialPageRoute(builder: (_) => ManufacturerHome()));
// //           break;
// //         case 1:
// //           Navigator.of(context).pushReplacement(
// //               MaterialPageRoute(builder: (_) => ProductsList()));
// //           break;
// //         case 2:
// //           Navigator.of(context)
// //               .push(MaterialPageRoute(builder: (_) => ProductsList()));
// //       }
// //     },
// //     letIndexChange: (index) => true,
// //   );
// // }

// class  extends StatefulWidget {
//   const ({Key? key}) : super(key: key);

//   @override
//   State<> createState() => _State();
// }

// class _State extends State<> {
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }

// Widget CommonBottomNavigationBar(BuildContext context) {
//   //GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//   int pageIndex = 0;
  
//   final pages = [
//     ProductsList(),
//     ProductsList(),
//      ProductsList(),
//      ProductsList(),
//   ];
//   return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 0;
//               });
//             },
//             icon: pageIndex == 0
//                 ? const Icon(
//                     Icons.home_filled,
//                     color: Colors.white,
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.home_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 1;
//               });
//             },
//             icon: pageIndex == 1
//                 ? const Icon(
//                     Icons.work_rounded,
//                     color: Colors.white,
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.work_outline_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 2;
//               });
//             },
//             icon: pageIndex == 2
//                 ? const Icon(
//                     Icons.widgets_rounded,
//                     color: Colors.white,
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.widgets_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 pageIndex = 3;
//               });
//             },
//             icon: pageIndex == 3
//                 ? const Icon(
//                     Icons.person,
//                     color: Colors.white,
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.person_outline,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//         ],
//       ),
//     );
// }
