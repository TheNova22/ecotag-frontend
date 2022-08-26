// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> items = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  String _chosenValue = "";

  @override
  void initState() {
    super.initState();
    var currentMonth = DateTime.now().month;
    _chosenValue = items[currentMonth - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: DropdownButton<String>(
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        value: _chosenValue,
        //elevation: 5,
        dropdownColor: const Color.fromARGB(255, 0, 152, 155),
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontFamily: "Acme"),

        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: const Text(
          " ",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (String? value) {
          setState(() {
            _chosenValue = value!;
          });
        },
      ),
    );
  }
}
