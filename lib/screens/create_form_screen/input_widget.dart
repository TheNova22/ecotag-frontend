import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sih_frontend/model/input_type.dart';

class FormInputWidget extends StatefulWidget {
  FormInputWidget({
    Key? key,
    this.inputName,
    this.inputType,
    required this.tc,
    required this.titletc,
  }) : super(key: key);
  final String? inputName;
  InputType? inputType;
  final TextEditingController tc, titletc;
  @override
  State<FormInputWidget> createState() => _FormInputWidgetState();
}

class _FormInputWidgetState extends State<FormInputWidget> {
  InputType innerInputType = InputType.text;
  late Widget inputTitle, inputBox;
  @override
  Widget build(BuildContext context) {
    inputTitle = widget.inputName == null
        ? TextField(
            controller: widget.titletc,
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
                    borderRadius: BorderRadius.circular(15.0))))
        : AutoSizeText(
            widget.inputName!,
            minFontSize: 9,
            maxLines: 3,
            style: GoogleFonts.openSans(
                fontSize: 18,
                color: const Color(0xff464646),
                fontWeight: FontWeight.w600),
          );
    inputBox = ((widget.inputType ?? InputType.text) == InputType.text)
        ? TextField(
            controller: widget.tc,
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
                    borderRadius: BorderRadius.circular(15.0))))
        : RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              widget.tc.text = rating.toString();
            },
          );

    return Column(
      children: [
        inputTitle,
        inputBox,
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
