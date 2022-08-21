// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:sih_frontend/screens/homePage/home_page.dart';
import 'package:sih_frontend/screens/productsScreen/components/session1.dart';
import 'package:sih_frontend/screens/productsScreen/components/session2.dart';
import 'package:sih_frontend/screens/productsScreen/components/session3.dart';
import 'package:sih_frontend/screens/productsScreen/components/session4.dart';
import 'package:sih_frontend/screens/productsScreen/components/session5.dart';
import 'package:flutter/material.dart';
import 'components/components/CreateShipmentsession1.dart';
import 'components/components/CreateShipmentsession2.dart';

class CreateShipment extends StatefulWidget {
  const CreateShipment({Key? key}) : super(key: key);

  @override
  State<CreateShipment> createState() => _CreateShipmentState();
}

class _CreateShipmentState extends State<CreateShipment> {
  int sessionNumber = 1;
  List answers = [];

  // startLocation, location and enroute_to
// {"shipmentID" : "62fbba53bad3f183e0f6fb00", "location" :"DESTINATION WAREHOUSE", "currentLat" : 192.35, "currentLong" : 80.45, "transportMode" : "-", "enroute_to" : "DESTINATION", "status" : "OUT FOR DELIVERY/DELIVERED"}
// {"manufacturer" : "aaa", "startLocation" : "ABC Speaker Maker, Bangalore", "pid" : "zxcv", "totalWeight" : 50.4, "currentLat" : 128.35, "currentLong" : 74.45}
  // TODO: Complete submitAnswers
  //answers example
  // [uncle chips, 123456789, 30.0, 100, 20.0, Plastic, [[potato, 70.0], [salt, 10.0]], [[987654321, 10.0], [135798642, 20.5]], [10.0, 20.4, 78.0, 12.0, 67.0]]
  Widget submitAnswers() {
    print("-----------------------");
    print(answers);
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return sessionNumber == 1
        ? CreateShipmentSession1(
            onNext: (int addNum, String q1, String q2, String q3) {
            setState(() {
              sessionNumber += addNum;
              answers.add(q1);
              answers.add(q2);
              answers.add(q3);
            });
          })
        : (sessionNumber == 2
            ? CreateShipmentSession2(
                onNext: (int addNum, String q1, String q2, String q3) {
                setState(() {
                  sessionNumber += addNum;
                  answers.add(q1);
                  answers.add(q2);
                  answers.add(q3);
                });
              })
            : submitAnswers());
  }
}
