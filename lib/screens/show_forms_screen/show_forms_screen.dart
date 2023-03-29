import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/inspection_form.dart';
import 'package:sih_frontend/screens/create_form_screen/create_form_screen.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';

class ShowFormsScreen extends StatelessWidget {
  const ShowFormsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const CreateFormScreen(),
              ),
            );
          },
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.25,
                              child: AutoSizeText(
                                "National Form Reposirory",
                                minFontSize: 9,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    color: Color(0xff464646),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FutureBuilder(
                              future: EcoTagAPI().getInspectionForms(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                                    ],
                                  );
                                }
                                if (snapshot.hasError ||
                                    (snapshot.data as List).isEmpty) {
                                  return SizedBox(
                                    height: 30,
                                    child: AutoSizeText(
                                      "Any new standard form will be listed here",
                                      minFontSize: 8,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }
                                return Center(
                                  child: Column(
                                      children: (snapshot.data
                                              as List<InspectionForm>)
                                          .map((e) => FormCard(f: e)
                                              // ListTile(
                                              //       title: Text(e.formName),
                                              //       trailing: IconButton(
                                              //         icon: const Icon(Icons.edit),
                                              //         onPressed: () {
                                              //           Navigator.push(
                                              //             context,
                                              //             MaterialPageRoute(
                                              //               builder: (BuildContext
                                              //                       context) =>
                                              //                   CreateFormScreen(
                                              //                 formData: e,
                                              //                 enteringData: false,
                                              //               ),
                                              //             ),
                                              //           );
                                              //         },
                                              //       ),
                                              //       leading: IconButton(
                                              //         icon: const Icon(
                                              //             Icons.format_align_center),
                                              //         onPressed: () {
                                              //           Navigator.push(
                                              //             context,
                                              //             MaterialPageRoute(
                                              //               builder: (BuildContext
                                              //                       context) =>
                                              //                   CreateFormScreen(
                                              //                 formData: e,
                                              //                 enteringData: true,
                                              //               ),
                                              //             ),
                                              //           );
                                              //         },
                                              //       ),
                                              //     )

                                              )
                                          .toList()),
                                );
                              })
                        ])))));
  }
}

class FormCard extends StatelessWidget {
  const FormCard({Key? key, required this.f}) : super(key: key);

  final InspectionForm f;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CreateFormScreen(
              formData: f,
              enteringData: true,
            ),
          ),
        );
      },
      child: Container(
        width: w / 1.1,
        height: 90,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                color: Color.fromARGB(40, 0, 0, 0),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.1,
              child: AutoSizeText(
                f.formName.toUpperCase(),
                minFontSize: 9,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                    color: Color(0xff464646),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  MaterialButton(
                    minWidth: 0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CreateFormScreen(
                            formData: f,
                            enteringData: false,
                          ),
                        ),
                      );
                    },
                    color: Color.fromARGB(255, 122, 168, 109),
                    textColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
