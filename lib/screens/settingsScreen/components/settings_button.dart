import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/screens/settingsScreen/components/settings_title.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.leading})
      : super(key: key);
  final void Function() onTap;
  final String title;
  final Widget leading;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      alignment: Alignment.centerLeft,
      width: width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 119, 119, 119).withOpacity(0.2),
              offset: Offset(0, 2.0),
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 214, 214, 214)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                  ),
                ),
                leading,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
