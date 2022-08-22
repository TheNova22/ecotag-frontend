import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateShipmentSession1 extends StatelessWidget {
  final Function(int, String, String, String) onNext;
// {"manufacturer" : "aaa", "startLocation" : "ABC Speaker Maker, Bangalore", "pid" : "zxcv", "totalWeight" : 50.4, "currentLat" : 128.35, "currentLong" : 74.45}
// {"shipmentID" : "62fbba53bad3f183e0f6fb00", "location" :"DESTINATION WAREHOUSE", "currentLat" : 192.35, "currentLong" : 80.45, "transportMode" : "-", "enroute_to" : "DESTINATION", "status" : "OUT FOR DELIVERY/DELIVERED"}
  List<String> questions = [
    "Start Location",
    "Destination Location",
    "Barcode of the product you are shipping",
    "Your current location co-ordinates",
    "What is the total weight(in Kg) of the product being Shipped?",
    "Transport mode",
  ];
  TextEditingController question1TextController = TextEditingController();
  TextEditingController question2TextController = TextEditingController();
  TextEditingController question3TextController = TextEditingController();
  CreateShipmentSession1({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: AutoSizeText(
                    "New Shipment",
                    minFontSize: 9,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: "Lobster",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Survey1()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            onNext(1, question1TextController.text,
                question2TextController.text, question3TextController.text);
          },
          foregroundColor: Colors.black87,
          backgroundColor: const Color.fromARGB(255, 159, 205, 243),
          child: const Icon(Icons.arrow_right_alt)),
    );
  }

  Widget Survey1() {
    return Column(
      children: [
        const SizedBox(height: 10),
        //question 1
        AutoSizeText(
          questions[0],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextField(
            controller: question1TextController,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    // borderSide: const BorderSide(
                    //     color: Color.fromARGB(255, 243, 235, 171), width: 32.0),
                    borderRadius: BorderRadius.circular(15.0)))),
        const SizedBox(height: 20),
        // question 2
        AutoSizeText(
          questions[1],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextField(
            controller: question2TextController,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    // borderSide: const BorderSide(
                    //     color: Color.fromARGB(255, 243, 235, 171), width: 32.0),
                    borderRadius: BorderRadius.circular(15.0)))),
        const SizedBox(height: 20),
        // question 3
        AutoSizeText(
          questions[2],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: question3TextController,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
              // borderSide: const BorderSide(
              //     color: Color.fromARGB(255, 243, 235, 171), width: 32.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.camera_outlined),
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    "#ff6666", 'Cancel', true, ScanMode.BARCODE);
                question3TextController.text = barcodeScanRes;
              },
            ),
          ),
        ),
      ],
    );
  }
}
