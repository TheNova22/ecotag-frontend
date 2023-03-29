import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/inspection_form.dart';
import 'package:sih_frontend/screens/create_form_screen/inspection_form_widget.dart';

class CreateFormScreen extends StatelessWidget {
  const CreateFormScreen({Key? key, this.formData, this.enteringData})
      : super(key: key);
  final InspectionForm? formData;
  final bool? enteringData;

  @override
  Widget build(BuildContext context) {
    print(formData.toString() + "slkfmslkfm");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AutoSizeText(
                      (formData != null)
                          ? (enteringData! == false
                              ? "Edit form"
                              : formData!.formName)
                          : "Create new form",
                      minFontSize: 9,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                          color: Color(0xff464646),
                          fontSize: 30,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 10),
                InspectionFormWidget(
                  formData: formData,
                  enteringData: enteringData,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
