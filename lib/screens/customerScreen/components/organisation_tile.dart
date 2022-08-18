import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganisationTile extends StatelessWidget {
  final String url;
  final String org_name, org_desc, org_img_url;
  const OrganisationTile(
      {Key? key,
      this.url = "",
      this.org_name = "",
      this.org_desc = "",
      this.org_img_url = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "CarbonFund.org",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            subtitle: const Text("Reduce What You Can, Offset What You Can’t"),
            trailing: Image.asset("assets/carbon.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 52, 156, 120)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  const BorderSide(color: Colors.blueAccent)))),
                  child: Text(
                    "Donate",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(114, 148, 197, 208)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Color(0x94C5D0))))),
                  child: Text(
                    "Know more",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
