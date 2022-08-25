import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Session2 extends StatefulWidget {
  final Function(int, String, String, String) onNext;

  Session2({Key? key, required this.onNext}) : super(key: key);

  @override
  State<Session2> createState() => _Session2State();
}

class _Session2State extends State<Session2> {
  List<String> items = <String>['Plastic', 'Paper', 'Cardboard', 'Other'];

  String _chosenValue = "";

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

  TextEditingController question4TextController = TextEditingController();

  TextEditingController question5TextController = TextEditingController();

  TextEditingController question6TextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chosenValue = items[0];
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
                Survey2()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "s2",
          onPressed: () {
            widget.onNext(1, question4TextController.text,
                question5TextController.text, _chosenValue);
          },
          child: const Icon(Icons.arrow_right_alt),
          foregroundColor: Colors.black87,
          backgroundColor: const Color.fromARGB(255, 159, 205, 243)),
    );
  }

  Widget Survey2() {
    return Column(
      children: [
        SizedBox(height: 10),
        //question 4
        AutoSizeText(
          questions[3],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextField(
            controller: question4TextController,
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
        SizedBox(height: 20),
        // question 5
        AutoSizeText(
          questions[4],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextField(
            controller: question5TextController,
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
        SizedBox(height: 20),
        // question 6
        AutoSizeText(
          questions[5],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),
            value: _chosenValue,
            elevation: 1,
            dropdownColor: Colors.white,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: const Text(
              " ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (String? value) {
              setState(() {
                _chosenValue = value!;
              });
            },
          ),
        )
      ],
    );
  }
}
