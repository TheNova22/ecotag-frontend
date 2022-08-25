// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/model/product.dart';
import 'package:sih_frontend/model/shipment.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';

import '../../shipment_update_screen/UpdateShipment.dart';

class ShipmentItem extends StatefulWidget {
  const ShipmentItem({Key? key, required this.shipment}) : super(key: key);

  final Shipment shipment;

  @override
  State<ShipmentItem> createState() => _ShipmentItemState();
}

class _ShipmentItemState extends State<ShipmentItem> {
  String imgUrl =
      "https://www.vuescript.com/wp-content/uploads/2018/11/Show-Loader-During-Image-Loading-vue-load-image.png";
  String name = "";

  Future<List> getDetails() async {
    Product res = await EcoTagAPI()
        .getProductDetailsByBarcode(barcode: widget.shipment.pid);

    return [res.image_url, res.name];
  }

  @override
  void initState() {
    super.initState();

    getDetails().then((value) {
      print(value);
      setState(() {
        imgUrl = value[0];
        name = value[1];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => UpdateShipment(
            shipmentIDWhenUpdate: widget.shipment.id["\$oid"] ?? "",
          ),
        ),
      ),
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 15),
        margin: const EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: const Color.fromARGB(255, 248, 248, 248),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(0.0, 2.0))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 36.0,
              backgroundImage: NetworkImage(
                imgUrl,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.shipment.totalWeight} Kg | ${widget.shipment.emission.toStringAsFixed(2)} kg CO\u2082",
                    style: GoogleFonts.openSans(
                        color: const Color(0xff464646),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    // place,
                    name,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    // "Enroute CA, USA"
                    style: GoogleFonts.openSans(
                        color: const Color(0xff464646),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.airport_shuttle_rounded),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        // place,
                        widget.shipment.status == "TRAVEL"
                            ? "Enroute ${widget.shipment.enroute_to}"
                            : (widget.shipment.status == "OUT FOR DELIVERY")
                                ? "Out for delivery"
                                : (widget.shipment.status == "DELIVERED")
                                    ? "Delivered"
                                    : "Processing",

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,

                        style: GoogleFonts.openSans(
                            color: const Color.fromARGB(255, 4, 67, 28),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
