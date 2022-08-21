import 'package:flutter/material.dart';
import 'package:sih_frontend/screens/productsScreen/add_product.dart';
import 'package:sih_frontend/screens/productsScreen/components/productListItem.dart';
import 'package:sih_frontend/widgets/common_navigation_bar.dart';

class ProductsList extends StatefulWidget {
  ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Products",
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontFamily: "Lobster",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blueAccent,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 32.0),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(15.0)))),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) => const ProductListItem()),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddProduct()));
          },
          child: Icon(Icons.add),
          foregroundColor: Colors.black87,
          backgroundColor: Color.fromARGB(255, 159, 205, 243)),
    );
  }
}