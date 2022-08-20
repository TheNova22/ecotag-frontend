import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShipmentItem extends StatefulWidget {
  const ShipmentItem({super.key});

  @override
  State<ShipmentItem> createState() => _ShipmentItemState();
}

class _ShipmentItemState extends State<ShipmentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 15),
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color.fromARGB(255, 248, 248, 248),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 36.0,
            backgroundImage: NetworkImage(
              "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses-green-hair_23-2149436201.jpg?w=740&t=st=1660905781~exp=1660906381~hmac=7f04bebb70269c0dc8034da7a85c164b5004455b80ecf477e774d8f47cb8cd82",
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  // "Hi, $name",
                  "25 Kgs | 60 units | 7 boxes",
                  style: TextStyle(
                    fontSize: 14.0,
                    // fontFamily: "Lobster",
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  // place,
                  "Birdie Superfoods -100% Pure A2 Gir Cow Milk ",

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  // "Enroute CA, USA"
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromARGB(215, 48, 48, 47),
                    fontFamily: "Acme",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: const [
                    Icon(Icons.airport_shuttle_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      // place,
                      "Enroute CA, USA",

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,

                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(135, 65, 65, 65),
                        // fontFamily: "Acme",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
