// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:sih_frontend/screens/homePage/home_page.dart';
import 'package:sih_frontend/screens/productsScreen/components/session1.dart';
import 'package:sih_frontend/screens/productsScreen/components/session2.dart';
import 'package:sih_frontend/screens/productsScreen/components/session3.dart';
import 'package:sih_frontend/screens/productsScreen/components/session4.dart';
import 'package:sih_frontend/screens/productsScreen/components/session5.dart';
import 'package:flutter/material.dart';
import 'package:sih_frontend/utils/api_functions.dart';
import 'package:sih_frontend/utils/authentication.dart';
import 'package:sih_frontend/utils/climatiq.dart';
import 'package:sih_frontend/utils/globals.dart' as globals;

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int sessionNumber = 1;
  List answers = [];
  List<String> cats = [
    "Food",
    "Gourmet",
    "Exercise",
    "Automotive",
    "Clothing",
    "Chips",
    "Shoes",
    "Pickles",
    "Sweets",
    "Spices"
  ];
  double emission = 0;
  double perBatch = 0;
  double weight = 0;
  List<bool> selects = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Future getCats(String name) async {
    await EcoTagAPI().predictCategories(searchTerm: name).then((value) {
      cats = value;
    });
  }

  Future updateEmission(List arr) async {
    for (int i = 0; i < arr.length; i++) {
      await Climatiq().getEmissions(arr[i][0], arr[i][1]).then((value) {
        emission += value["co2e"];
      });
    }
  }

  Future updateWaste(List arr) async {
    List ids = [
      "waste_type_batteries-disposal_method_landfill",
      "waste_type_scrap_metal-disposal_method_closed_loop",
      "waste_type_mixed_paper_general-disposal_method_landfilled",
      "waste_type_ldpe-disposal_method_landfilled",
      "waste_type_food_waste-disposal_method_landfilled"
    ];
    for (int i = 0; i < arr.length; i++) {
      await Climatiq().getEmissionsFromId(ids[0], arr[i]).then((value) {
        emission += value["co2e"];
      });
    }
  }

  int countSelects() {
    int ct = 0;
    for (int i = 0; i < selects.length; i++) {
      if (selects[i]) {
        ct += 1;
      }
    }
    return ct;
  }

  // TODO: Complete submitAnswers
  //answers example
  // [uncle chips, 123456789, 30.0, 100, 20.0, Plastic, [[potato, 70.0], [salt, 10.0]], [[987654321, 10.0], [135798642, 20.5]], [10.0, 20.4, 78.0, 12.0, 67.0]]
  Future submitAnswers() async {
    print("-----------------------");
    print(answers);
    if (countSelects() != 5) {
      showToast("Select 5 categories");
      return;
    }

    List<String> selectedCats = [];

    for (int i = 0; i < selects.length; i++) {
      if (selects[i]) {
        selectedCats.add(cats[i]);
      }
    }

    selectedCats.sort();
    await EcoTagAPI()
        .addProduct(
            name: answers[0],
            category: selectedCats,
            weight: weight,
            price: answers[2],
            emission: emission,
            manufacturer: globals.uid,
            barcode: answers[1],
            rawMaterials: answers[6],
            components: answers[7])
        .then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    void updateI(int index) {
      int ct = 0;
      for (int i = 0; i < selects.length; i++) {
        if (selects[i]) {
          ct += 1;
        }
      }
      if (selects[index] == false) {
        if (ct < 5) {
          setState(() {
            selects[index] = true;
          });
        }
      } else {
        setState(() {
          selects[index] = false;
        });
      }
    }

    return sessionNumber == 1
        ? Session1(onNext: (int addNum, String q1, String q2, String q3) {
            setState(() {
              sessionNumber += addNum;
              answers.add(q1);
              getCats(q1);
              answers.add(q2);
              answers.add(double.parse(q3));
            });
          })
        : (sessionNumber == 2
            ? Session2(onNext: (int addNum, String q1, String q2, String q3) {
                setState(() {
                  sessionNumber += addNum;
                  answers.add(double.parse(q1));
                  perBatch = double.parse(q1);
                  answers.add(double.parse(q2));
                  weight = double.parse(q2);
                  answers.add(q3);
                });
              })
            : (sessionNumber == 3
                ? Session3(onNext: (int addNum, List ans) {
                    setState(() {
                      sessionNumber += addNum;
                      updateEmission(ans);
                      answers.add(ans);
                    });
                  })
                : (sessionNumber == 4
                    ? Session4(onNext: (int addNum, List ans) {
                        setState(() {
                          sessionNumber += addNum;
                          answers.add(ans);
                        });
                      })
                    : (sessionNumber == 5
                        ? Session5(onNext: (int addNum, List ans) {
                            setState(() {
                              sessionNumber += addNum;
                              answers.add(ans);
                              updateWaste(ans);
                              print("--------------------------------");
                              print(answers);
                            });
                          })
                        : (sessionNumber == 6
                            ? Scaffold(
                                floatingActionButton: FloatingActionButton(
                                    onPressed: () {
                                      submitAnswers();
                                    },
                                    child: const Icon(Icons.arrow_right_alt),
                                    foregroundColor: Colors.black87,
                                    backgroundColor: const Color.fromARGB(
                                        255, 159, 205, 243)),
                                body: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Select 5 categories that best define your product"),
                                          GridView.count(
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            childAspectRatio: 3,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            children: cats.map((e) {
                                              return GestureDetector(
                                                onTap: () {
                                                  updateI(cats.indexOf(e));
                                                },
                                                child: Container(
                                                    width: 20,
                                                    alignment: Alignment.center,
                                                    // padding: EdgeInsets.only(
                                                    //     top: 10, bottom: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Color.fromARGB(
                                                              255,
                                                              106,
                                                              182,
                                                              244)),
                                                      color: selects[
                                                              cats.indexOf(e)]
                                                          ? Color.fromARGB(255,
                                                              188, 233, 187)
                                                          : Color.fromARGB(255,
                                                              217, 246, 239),
                                                    ),
                                                    child: Text(
                                                      e,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: TextButton(
                                    onPressed: submitAnswers,
                                    child: Text("Submit")),
                              ))))));
  }
}
