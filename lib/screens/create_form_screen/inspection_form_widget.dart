import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/input_type.dart';
import 'package:sih_frontend/model/inspection_form.dart';
import 'package:sih_frontend/screens/create_form_screen/input_widget.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';

import '../../model/inspection_form.dart';
import '../../utils/ecotag_functions.dart';

class InspectionFormWidget extends StatefulWidget {
  const InspectionFormWidget({Key? key, this.formData, this.enteringData})
      : super(key: key);
  final InspectionForm? formData;
  final bool? enteringData;
  @override
  State<InspectionFormWidget> createState() => _InspectionFormWidgetState();
}

class _InspectionFormWidgetState extends State<InspectionFormWidget> {
  final TextEditingController formTitleController = TextEditingController();
  final TextEditingController manufacturerNameController =
      TextEditingController();
  final TextEditingController makerNameController = TextEditingController();
  List<FormInputWidget> formWidgets = [];

  void removeInput() {
    setState(() {
      formWidgets.removeLast();
    });
  }

  void addInput() {
    setState(() {
      final tc = TextEditingController();
      final title = TextEditingController();

      formWidgets.add(FormInputWidget(
        tc: tc,
        titletc: title,
      ));
    });
  }

  void addStar() {
    setState(() {
      final tc = TextEditingController();
      final title = TextEditingController();
      formWidgets.add(FormInputWidget(
        inputType: InputType.starrating,
        tc: tc,
        titletc: title,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.formData != null) {
      final InspectionForm form = widget.formData!;
      formTitleController.text = form.formName;
      for (int i = 0; i < form.inputFields.length; i++) {
        formWidgets.add(FormInputWidget(
            tc: TextEditingController(),
            titletc: TextEditingController(text: form.inputFields[i]),
            inputType: form.inputTypes[i] == "TEXT"
                ? InputType.text
                : InputType.starrating,
            inputName: (widget.enteringData ?? false) == false
                ? null
                : form.inputFields[i]));
      }
    }
    setState(() {});
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((widget.enteringData ?? false) != true)
            AutoSizeText(
              "Enter Form Title",
              minFontSize: 9,
              maxLines: 3,
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: const Color(0xff464646),
                  fontWeight: FontWeight.w600),
            ),
          if ((widget.enteringData ?? false) != true)
            TextField(
              controller: formTitleController,
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
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          AutoSizeText(
            "Manufacturer Name".toUpperCase(),
            minFontSize: 9,
            maxLines: 3,
            style: GoogleFonts.openSans(
                fontSize: 16,
                color: const Color(0xff464646),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: manufacturerNameController,
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
          SizedBox(
            height: 15,
          ),
          AutoSizeText(
            "Auditor Name".toUpperCase(),
            minFontSize: 9,
            maxLines: 3,
            style: GoogleFonts.openSans(
                fontSize: 16,
                color: const Color(0xff464646),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: makerNameController,
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
          ...formWidgets,
          if ((widget.enteringData ?? false) != true)
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.star), onPressed: addStar),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: addInput,
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: removeInput,
                  )
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  final String title = formTitleController.text;
                  List<String> inputTypes = [];
                  List<String> inputName = [];
                  List<String> resultValues = [];
                  for (FormInputWidget item in formWidgets) {
                    inputTypes.add(
                        (item.inputType ?? InputType.text) == InputType.text
                            ? "TEXT"
                            : "STAR");
                    inputName.add(item.titletc.text);
                    resultValues.add(item.tc.text);
                  }

                  InspectionForm f = InspectionForm(
                    id: '',
                    formName: title,
                    makerName: makerNameController.text,
                    inputTypes: inputTypes,
                    manufacturer: manufacturerNameController.text,
                    inputFields: inputName,
                  );

                  if ((widget.enteringData ?? false) == false) {
                    debugPrint("sending");
                    debugPrint(EcoTagAPI().addForm(form: f).toString());
                    debugPrint(
                        "Entering form values.${f.id} : ${resultValues}");
                    debugPrint(EcoTagAPI()
                        .enterFormValues(
                            resultValues: resultValues, formid: f.id)
                        .toString());
                  } else {
                    debugPrint(
                        "Entering form values.${f.id} : ${resultValues}");
                    debugPrint(EcoTagAPI()
                        .enterFormValues(
                            resultValues: resultValues, formid: f.id)
                        .toString());
                  }
                  debugPrint(f.toString());
                  debugPrint(resultValues.toString());
                },
                icon: const Icon(Icons.save),
                label: (widget.enteringData ?? false)
                    ? const Text("Save entered values")
                    : const Text("Save form and Values"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
