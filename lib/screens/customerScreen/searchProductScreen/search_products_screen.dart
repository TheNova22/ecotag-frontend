import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/product.dart';
import 'package:sih_frontend/screens/productsScreen/components/productListItem.dart';
import 'package:sih_frontend/screens/supplierFinder/supplier_finder.dart';
import 'package:sih_frontend/utils/api_functions.dart';

class SearchProducts extends StatefulWidget {
  SearchProducts({Key? key, required this.searchTerm}) : super(key: key);

  final String searchTerm;
  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  bool searched = false;
  List<Product> res = [];

  late TextEditingController searchController;

  Future searcher(String searchTerm) async {
    await EcoTagAPI().getProductByName(name: searchTerm).then((value) {
      setState(() {
        searched = true;
        res = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.searchTerm);

    searcher(widget.searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff464646),
        ),
      ),
      backgroundColor: Color(0xffECF0F1),
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45.0,
                        width: w / 1.4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30.0),
                        child: TextField(
                          controller: searchController,
                          cursorColor: Color.fromARGB(255, 152, 152, 152),
                          keyboardType: TextInputType.text,
                          onSubmitted: (val) {
                            searcher(val);
                          },
                          style: GoogleFonts.openSans(
                              color: Color(0xff464646),
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(22.0)),
                            // enabledBorder: const UnderlineInputBorder(
                            //     borderSide:
                            //         BorderSide(color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            border: const OutlineInputBorder(),
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                searcher(searchController.text);
                              },
                            ),
                            hintText: "Try Tea",
                            hintStyle: const TextStyle(color: Colors.grey),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.filter_alt,
                        size: 45,
                        color: Color.fromARGB(255, 171, 171, 171),
                      )
                    ],
                  ),
                  if (searched)
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(
                        children: res
                            .map((e) => ProductListItem(product: e))
                            .toList(),
                      ),
                    )
                ],
              ),
            ),
          )),
    );
  }
}
