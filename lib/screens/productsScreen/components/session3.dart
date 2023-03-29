// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Session3 extends StatefulWidget {
  final Function(int, List) onNext;

  const Session3({Key? key, required this.onNext}) : super(key: key);

  @override
  State<Session3> createState() => _Session3State();
}

class _Session3State extends State<Session3> {
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
  int fieldCount = 0;
  List<TextEditingController> controllersSession3 = <TextEditingController>[];
  List<Widget> children = [];

  void buildList() {
    controllersSession3.add(TextEditingController());
    controllersSession3.add(TextEditingController());
    int i = controllersSession3.length - 1;
    setState(() {
      children.add(Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession3[i - 1],
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)))),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession3[i],
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Weight",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)))),
            ),
          ],
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    fieldCount = 0;
    controllersSession3.add(TextEditingController());
    controllersSession3.add(TextEditingController());

    children.add(
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession3[0],
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)))),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession3[1],
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Weight",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)))),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    fieldCount++;

                    FocusScopeNode currentScope = FocusScope.of(context);
                    if (!currentScope.hasPrimaryFocus &&
                        currentScope.hasFocus) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                    buildList();
                  });
                },
                icon: const Icon(Icons.add, size: 20, color: Colors.red))
          ],
        ),
      ),
    );
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
                const Center(
                  child: AutoSizeText(
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
                Survey3()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "s3",
          onPressed: () {
            List answers = [];
            for (int i = 0; i < controllersSession3.length; i += 2) {
              answers.add([
                controllersSession3[i].text,
                double.parse(controllersSession3[i + 1].text)
              ]);
            }
            widget.onNext(1, answers);
          },
          foregroundColor: Colors.black87,
          backgroundColor: const Color.fromARGB(255, 159, 205, 243),
          child: const Icon(Icons.arrow_right_alt)),
    );
  }

  Widget Survey3() {
    return Column(
      children: [
        const SizedBox(height: 10),
        //question 7
        AutoSizeText(
          questions[6],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 20),
        ListView(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: children,
        ),
      ],
    );
  }
}
