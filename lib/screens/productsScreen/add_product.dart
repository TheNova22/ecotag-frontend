// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:sih_frontend/screens/homePage/home_page.dart';
import 'package:sih_frontend/screens/productsScreen/components/session1.dart';
import 'package:sih_frontend/screens/productsScreen/components/session2.dart';
import 'package:sih_frontend/screens/productsScreen/components/session3.dart';
import 'package:sih_frontend/screens/productsScreen/components/session4.dart';
import 'package:sih_frontend/screens/productsScreen/components/session5.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int sessionNumber = 1;
  List answers = [];

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
        ? Session1(onNext: (int addNum, String q1, String q2, String q3) {
            setState(() {
              sessionNumber += addNum;
              answers.add(q1);
              answers.add(q2);
              answers.add(double.parse(q3));
            });
          })
        : (sessionNumber == 2
            ? Session2(onNext: (int addNum, String q1, String q2, String q3) {
                setState(() {
                  sessionNumber += addNum;
                  answers.add(int.parse(q1));
                  answers.add(double.parse(q2));
                  answers.add(q3);
                });
              })
            : (sessionNumber == 3
                ? Session3(onNext: (int addNum, List ans) {
                    setState(() {
                      sessionNumber += addNum;
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
                              print("--------------------------------");
                              print(answers);
                            });
                          })
                        : submitAnswers()))));
  }
}
