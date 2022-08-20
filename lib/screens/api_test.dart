import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_frontend/screens/customerScreen/customer_screen.dart';
import 'package:sih_frontend/screens/reverseLogistics/reverse_logistics.dart';
import 'package:sih_frontend/screens/supplierFinder/supplier_finder.dart';
import 'package:sih_frontend/utils/api_functions.dart';

class APITestScreen extends StatelessWidget {
  const APITestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: TextButton(
                  child: const Text("getProductNameByBarcode"),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CustomerScreen()));
                    // EcoTagAPI()
                    //     .getProductNameByBarcode(barcode: "8901138511470");
                  },
                ),
              ),
              // TextButton(
              //   child: const Text("getProductFromBarcode"),
              //   onPressed: () async {
              //     final x =
              //         await EcoTagAPI().getProductFromBarcode(barcode: "zxcv");
              //     debugPrint(x.toString());
              //   },
              // ),
              TextButton(
                child: const Text("getManufacturers"),
                onPressed: () async {
                  final x = await EcoTagAPI().getManufacturers(maker: "maker");
                  debugPrint(x.toString());
                },
              ),
              TextButton(
                child: const Text("getShipments"),
                onPressed: () async {
                  final x = await EcoTagAPI().getShipments(manufacturer: "aaa");
                  debugPrint(x.toString());
                },
              ),
              TextButton(
                  child: const Text("getAllRoutes"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ReverseLogisticsScreen()));
                  }
                  // () async {
                  //   final x = await EcoTagAPI().getAllRoutes(
                  //       fromAddress: "Mathikere, Bangalore",
                  //       toAddress: "NIT Silchar, Silchar, Assam");
                  //   debugPrint(x.toString());
                  // },
                  ),
              TextButton(
                  child: const Text("getSupplierDetails"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SupplierFinder()));
                  }
                  // () async {
                  //   final x = await EcoTagAPI().getSupplierDetails(
                  //       searchTerm: "Mixed Fruit Jam",
                  //       latitude: 19.462,
                  //       longitude: 1412.594566);
                  //   debugPrint(x.toString());
                  // },
                  ),
              TextButton(
                child: const Text("getProductsByCategory"),
                onPressed: () async {
                  final x = await EcoTagAPI().getProductsByCategory(
                      categories: ["Plastic Material", "Leaf Water"]);
                  debugPrint(x.toString());
                },
              ),
              TextButton(
                child: const Text("getProductByName"),
                onPressed: () async {
                  final x = await EcoTagAPI().getProductByName(name: "water");
                  debugPrint(x.toString());
                },
              ),
              TextButton(
                child: const Text("getCategoriesByName"),
                onPressed: () async {
                  EcoTagAPI().getCategoriesByName(
                      name:
                          "Wheel Active 2 in 1 Detergent Powder - Clean and Fresh (Blue), Pack of 1kg Pouch");
                },
              ),
              TextButton(
                child: const Text("addShipment"),
                onPressed: () async {
                  EcoTagAPI().addShipment(
                      manufacturer: "aaa",
                      startLocation: "ABC Speaker Maker, Bangalore",
                      pid: "zxcv",
                      totalWeight: 50.4,
                      currentLat: 128.35,
                      currentLong: 74.45);
                },
              ),
              TextButton(
                child: const Text("addManufacturer"),
                onPressed: () async {
                  EcoTagAPI().addManufacturer(
                      id: "ccc",
                      company: "XYZ Speaker Maker",
                      lat: 333.213,
                      long: 123.1422,
                      address: "Central Kolkata, Kolkata, India",
                      phone: "+91358359938");
                },
              ),
              TextButton(
                child: const Text("updateShipment"),
                onPressed: () async {
                  EcoTagAPI().updateShipment(
                      shipmentID: "62fbba53bad3f183e0f6fb00",
                      location: "DESTINATION WAREHOUSE",
                      currentLat: 192.35,
                      currentLong: 80.45,
                      transportMode: "-",
                      enroute_to: "DESTINATION",
                      status: "OUT FOR DELIVERY/DELIVERED");
                },
              ),
              TextButton(
                child: const Text("addProduct"),
                onPressed: () async {
                  EcoTagAPI().addProduct(
                      name: "Leaf Water Bottle",
                      category: ["Fire Bottle", "Plastic Material"],
                      emission: 76.35,
                      manufacturer: "bbb",
                      barcode: "qwytu",
                      rawMaterials: ["Plastic"],
                      components: ["gslwoig"]);
                },
              ),
              IconButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
        ),
      ),
    );
  }
}
