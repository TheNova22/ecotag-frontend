// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sih_frontend/model/product.dart';
import 'package:sih_frontend/screens/productsScreen/add_product.dart';
import 'package:sih_frontend/screens/productsScreen/components/productListItem.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';
import 'package:sih_frontend/widgets/common_navigation_bar.dart';
import 'package:sih_frontend/utils/globals.dart' as globals;

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool dataLoaded = false;
  List<Product> prods = [];

  Future<List<Product>> listOfProducts() async {
    return await EcoTagAPI().getProductsByManufacturer(mid: globals.uid);
  }

  @override
  void initState() {
    super.initState();

    listOfProducts().then((finalArray) {
      setState(() {
        prods = finalArray;
        debugPrint(prods.length.toString());
        dataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: "Lobster",
                  ),
                ),
                if (!dataLoaded)
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: const [
                        Center(child: CircularProgressIndicator.adaptive()),
                      ],
                    ),
                  ),
                if (dataLoaded) ...[
                  const SizedBox(height: 10),
                  TextField(
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.blueAccent,
                      ),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 32.0),
                              borderRadius: BorderRadius.circular(15.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 32.0),
                              borderRadius: BorderRadius.circular(15.0)))),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: prods.length,
                      itemBuilder: (context, index) => ProductListItem(
                            product: prods[index],
                          )),
                ]
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "productList",
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddProduct()));
          },
          foregroundColor: Colors.black87,
          backgroundColor: const Color.fromARGB(255, 159, 205, 243),
          child: const Icon(Icons.add)),
    );
  }
}
