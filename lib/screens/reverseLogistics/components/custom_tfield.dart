import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.hint,
      required this.width,
      required this.height,
      required this.prefixIcon})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hint;
  final double width;
  final double height;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          prefixIcon,
          size: 35,
          color: const Color.fromARGB(255, 88, 83, 138),
        ),
        Container(
          width: width,
          height: height - 20,
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: const Color.fromARGB(255, 244, 244, 244),
            border: Border.all(
              color: const Color.fromRGBO(189, 189, 189, 1),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 15),
            cursorColor: const Color.fromARGB(255, 83, 82, 82),
            decoration: InputDecoration(
                hintText: hint,
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent))),
          ),
        )
      ],
    );
  }
}
