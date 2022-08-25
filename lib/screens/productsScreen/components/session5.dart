import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Session5 extends StatefulWidget {
  final Function(int, List) onNext;

  Session5({Key? key, required this.onNext}) : super(key: key);

  @override
  State<Session5> createState() => _Session5State();
}

class _Session5State extends State<Session5> {
  List<String> questions = [
    "What is the name of the product?",
    "What is the registered barcode of the product?",
    "What is the maximum retail price of the product?",
    "How many products are created per batch?",
    "What is the weight(in Kg) of the product?",
    "What sort of packaging do you opt for?",
    "Enter the Raw Materials used in making the product.",
    "Enter the barcode of other products used in making the product.",
    "What is the total waste(in kg) for these categories."
  ];

  TextEditingController question80TextController = TextEditingController();
  TextEditingController question81TextController = TextEditingController();
  TextEditingController question82TextController = TextEditingController();
  TextEditingController question83TextController = TextEditingController();
  TextEditingController question84TextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                Center(
                  child: const AutoSizeText(
                    "New Product",
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
                Survey5()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "s5",
          onPressed: () {
            List totalWaste = [];
            totalWaste.add(double.parse(question80TextController.text));
            totalWaste.add(double.parse(question81TextController.text));
            totalWaste.add(double.parse(question82TextController.text));
            totalWaste.add(double.parse(question83TextController.text));
            totalWaste.add(double.parse(question84TextController.text));
            widget.onNext(1, totalWaste);
          },
          child: const Icon(Icons.arrow_right_alt),
          foregroundColor: Colors.black87,
          backgroundColor: const Color.fromARGB(255, 159, 205, 243)),
    );
  }

  Widget Survey5() {
    return Column(
      children: [
        SizedBox(height: 10),
        //question 4
        AutoSizeText(
          questions[8],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              "Electric Waste",
              minFontSize: 9,
              maxLines: 3,
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: const Color(0xff464646),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextField(
                controller: question80TextController,
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
          ),
        ]),
        SizedBox(height: 20),
        Row(children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              "Metal Waste",
              minFontSize: 9,
              maxLines: 3,
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: const Color(0xff464646),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextField(
                controller: question81TextController,
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
          ),
        ]),
        SizedBox(height: 20),
        Row(children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              "Paper Waste",
              minFontSize: 9,
              maxLines: 3,
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: const Color(0xff464646),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextField(
                controller: question82TextController,
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
          ),
        ]),
        SizedBox(height: 20),
        Row(children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              "Plastic Waste",
              minFontSize: 9,
              maxLines: 3,
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: const Color(0xff464646),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextField(
                controller: question83TextController,
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
          ),
        ]),
        SizedBox(height: 20),
        Row(children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              "Food and Organic Waste",
              minFontSize: 9,
              maxLines: 3,
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: const Color(0xff464646),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextField(
                controller: question84TextController,
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
          ),
        ]),
      ],
    );
  }
}
