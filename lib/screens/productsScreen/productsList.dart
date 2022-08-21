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
                    itemBuilder: (context, index) => ProductListItem(
                          name:
                              "Birdie Superfoods -100% Pure A2 Gir Cow Desi Ghee Through Vedic Bilona Method ",
                          imgUrl:
                              "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses-green-hair_23-2149436201.jpg?w=740&t=st=1660905781~exp=1660906381~hmac=7f04bebb70269c0dc8034da7a85c164b5004455b80ecf477e774d8f47cb8cd82",
                          carbonEmission: 945.68,
                          rating: 3.4,
                          numOfManufacturers: 745,
                        )),
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
