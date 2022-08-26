import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sih_frontend/model/input_type.dart';
import 'package:sih_frontend/screens/create_form_screen/input_widget.dart';

class InspectionFormWidget extends StatefulWidget {
  const InspectionFormWidget({Key? key}) : super(key: key);

  @override
  State<InspectionFormWidget> createState() => _InspectionFormWidgetState();
}

class _InspectionFormWidgetState extends State<InspectionFormWidget> {
  List<FormInputWidget> formWidgets = [];
  void removeInput() {
    if (formWidgets.length > 1) {
      setState(() {
        formWidgets.removeLast();
      });
    }
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
    return Column(
      children: [
        ...formWidgets,
        Row(
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
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            for (FormInputWidget item in formWidgets) {
              print(item.titletc.text + " " + item.tc.text);
            }
          },
        )
      ],
    );
  }
}
