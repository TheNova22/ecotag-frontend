import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Session4 extends StatefulWidget {
  final Function(int, List) onNext;

  Session4({Key? key, required this.onNext}) : super(key: key);

  @override
  State<Session4> createState() => _Session4State();
}

class _Session4State extends State<Session4> {
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
  List<TextEditingController> controllersSession4 = <TextEditingController>[];
  List<Widget> children = [];

  void buildList() {
    controllersSession4.add(TextEditingController());
    controllersSession4.add(TextEditingController());
    int i = controllersSession4.length - 1;
    setState(() {
      children.add(Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession4[i - 1],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Barcode",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)))),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession4[i],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Weight (in kg)",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)))),
            ),
          ],
        ),
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fieldCount = 0;
    controllersSession4.add(TextEditingController());
    controllersSession4.add(TextEditingController());

    children.add(
      Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession4[0],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Barcode",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)))),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextField(
                  controller: controllersSession4[1],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Weight (in kg)",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
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
                icon: Icon(Icons.add, size: 20, color: Colors.red))
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
                Survey4()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            List answers = [];
            for (int i = 0; i < controllersSession4.length; i += 2) {
              answers.add([
                controllersSession4[i].text,
                double.parse(controllersSession4[i + 1].text)
              ]);
            }
            widget.onNext(1, answers);
          },
          child: const Icon(Icons.arrow_right_alt),
          foregroundColor: Colors.black87,
          backgroundColor: const Color.fromARGB(255, 159, 205, 243)),
    );
  }

  Widget Survey4() {
    return Column(
      children: [
        SizedBox(height: 10),
        //question 8
        AutoSizeText(
          questions[7],
          minFontSize: 9,
          maxLines: 3,
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: const Color(0xff464646),
              fontWeight: FontWeight.w600),
        ),

        SizedBox(height: 20),
        ListView(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: children,
        ),
      ],
    );
  }
}
