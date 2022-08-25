// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sih_frontend/screens/homePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';
import 'package:sih_frontend/utils/authentication.dart';
import 'components/components/CreateShipmentsession1.dart';
import 'components/components/CreateShipmentsession2.dart';

class CreateShipment extends StatefulWidget {
  const CreateShipment({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateShipment> createState() => _CreateShipmentState();
}

class _CreateShipmentState extends State<CreateShipment> {
  int sessionNumber = 1;
  List answers = [];
  late String manufacturer,
      startLocation,
      pid,
      shipmentID,
      curlocation,
      transportMode,
      enroute_to,
      status;
  late double currentLat, currentLong, totalWeight;
  Widget submitAnswers() {
    debugPrint("-----------------------");
    debugPrint(answers.toString());

    return const HomePage();
  }

// [indi, america, 8901138511470, 13.033653,77.5635221, 45, Rail]
  @override
  Widget build(BuildContext context) {
    // debugPrint(FirebaseAuth.instance.currentUser!.uid);
    return sessionNumber == 1
        ? CreateShipmentSession1(
            onNext: (int addNum, String q1, String q2, String q3) {
            setState(() {
              sessionNumber += addNum;
              startLocation = curlocation = q1;
              enroute_to = q2;
              pid = q3;
            });
          })
        : (sessionNumber == 2
            ? CreateShipmentSession2(
                onNext: (int addNum, String q1, String q2, String q3) async {
                List<String> latlng = q1.split(",");
                currentLat = double.parse(latlng[0]);
                currentLong = double.parse(latlng.last);
                totalWeight = double.parse(q2);
                transportMode = q3;
                User? u = FirebaseAuth.instance.currentUser;
                manufacturer = (u != null) ? u.uid : "";
                final Map<String, dynamic> res = await EcoTagAPI().addShipment(
                    manufacturer: manufacturer,
                    currentLat: currentLat,
                    currentLong: currentLong,
                    pid: pid,
                    startLocation: startLocation,
                    totalWeight: totalWeight);
                // {"id": {"$oid": "63026d9b27577b9760237048"}}
                Map<String, dynamic> id = res['id'];
                final String shipmentId = id["\$oid"];
                final Map<String, dynamic> result = await EcoTagAPI()
                    .updateShipment(
                        shipmentID: shipmentId,
                        location: curlocation,
                        currentLat: currentLat,
                        currentLong: currentLong,
                        transportMode: transportMode,
                        enroute_to: enroute_to,
                        status: "PROCESSING");
                if (result["status"]) {
                  showToast("Added Shipment with id $shipmentId");
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
