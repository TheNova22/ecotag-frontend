// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sih_frontend/screens/homePage/home_page.dart';
import 'package:sih_frontend/screens/productsScreen/components/session1.dart';
import 'package:sih_frontend/screens/productsScreen/components/session2.dart';
import 'package:sih_frontend/screens/productsScreen/components/session3.dart';
import 'package:sih_frontend/screens/productsScreen/components/session4.dart';
import 'package:sih_frontend/screens/productsScreen/components/session5.dart';
import 'package:flutter/material.dart';
import '../../utils/api_functions.dart';
import '../../utils/authentication.dart';
import 'components/components/UpdateShipmentsession1.dart';
import 'components/components/UpdateShipmentsession2.dart';

class UpdateShipment extends StatefulWidget {
  const UpdateShipment({Key? key}) : super(key: key);

  @override
  State<UpdateShipment> createState() => _UpdateShipmentState();
}

class _UpdateShipmentState extends State<UpdateShipment> {
  int sessionNumber = 1;
  List answers = [];
  late String shipmentID, curlocation, transportMode, enroute_to, status;
  late double currentLat, currentLong;
  // startLocation, location and enroute_to
// {"shipmentID" : "62fbba53bad3f183e0f6fb00", "location" :"DESTINATION WAREHOUSE", "currentLat" : 192.35, "currentLong" : 80.45, "transportMode" : "-", "enroute_to" : "DESTINATION", "status" : "OUT FOR DELIVERY/DELIVERED"}
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
        ? UpdateShipmentSession1(
            onNext: (int addNum, String q1, String q2, String q3) {
            setState(() {
              sessionNumber += addNum;
              shipmentID = q1;
              curlocation = q2;
              enroute_to = q3;
              answers.add(q1);
              answers.add(q2);
              answers.add(q3);
            });
          })
        : (sessionNumber == 2
            ? UpdateShipmentSession2(
                onNext: (int addNum, String q1, String q2, String q3) async {
                List<String> latlng = q2.split(",");
                currentLat = double.parse(latlng[0]);
                currentLong = double.parse(latlng.last);
                status = q1;
                transportMode = q3;

                final Map<String, dynamic> result =
                    await EcoTagAPI().updateShipment(
                  shipmentID: shipmentID,
                  location: curlocation,
                  currentLat: currentLat,
                  currentLong: currentLong,
                  transportMode: transportMode,
                  enroute_to: enroute_to,
                  status: status,
                );
                if (result["status"]) {
                  showToast("Updated Shipment with id $shipmentID");
                }
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
