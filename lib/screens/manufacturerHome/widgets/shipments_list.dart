import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/screens/manufacturerHome/widgets/shipment_item.dart';

import '../../../model/shipment.dart';
import '../../../utils/api_functions.dart';

class ShipmentsList extends StatelessWidget {
  const ShipmentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Your Shipments",
          style: GoogleFonts.openSans(
              color: const Color(0xff464646),
              fontSize: 24,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder(
          future: EcoTagAPI().getShipments(
              manufacturer: FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting ||
                (snapshot.data as List).isEmpty) {
              return SizedBox(
                height: 30,
                child: AutoSizeText(
                  "Your Shipments will appear here",
                  minFontSize: 8,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              );
            }
            List<Shipment> s = snapshot.data as List<Shipment>;
            List<Shipment> inTransit =
                s.where((element) => element.status == "TRAVEL").toList();
            List<Shipment> delivered =
                s.where((element) => element.status == "DELIVERED").toList();
            List<Shipment> processing =
                s.where((element) => element.status == "PROCESSING").toList();
            List<Shipment> outForDelivery = s
                .where((element) => element.status == "OUT FOR DELIVERY")
                .toList();
            List<Widget> ret = [];
            if (processing.isNotEmpty) {
              ret.add(Text(
                "Processing".toUpperCase(),
                style: GoogleFonts.openSans(
                    color: const Color(0xff464646),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ));
              ret.add(const SizedBox(
                height: 10,
              ));
              for (Shipment shipment in processing) {
                ret.add(ShipmentItem(
                  name: shipment.pid,
                  weight: shipment.totalWeight,
                  emission: shipment.emission,
                  status: shipment.status,
                  enroute_to: shipment.enroute_to,
                  shipmentId: shipment.id["\$oid"] ?? "",
                ));
              }
            }
            if (inTransit.isNotEmpty) {
              ret.add(Text(
                "In Transit".toUpperCase(),
                style: GoogleFonts.openSans(
                    color: const Color(0xff464646),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ));
              ret.add(const SizedBox(
                height: 10,
              ));
              for (Shipment shipment in inTransit) {
                ret.add(ShipmentItem(
                  name: "Name of item",
                  weight: shipment.totalWeight,
                  emission: shipment.emission,
                  status: shipment.status,
                  enroute_to: shipment.enroute_to,
                  shipmentId: shipment.id["\$oid"] ?? "",
                ));
              }
            }
            if (outForDelivery.isNotEmpty) {
              ret.add(Text(
                "Out for Delivery".toUpperCase(),
                style: GoogleFonts.openSans(
                    color: const Color(0xff464646),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ));
              ret.add(const SizedBox(
                height: 10,
              ));
              for (Shipment shipment in outForDelivery) {
                ret.add(ShipmentItem(
                    shipmentId: shipment.id["\$oid"] ?? "",
                    name: "Name of item",
                    weight: shipment.totalWeight,
                    emission: shipment.emission,
                    status: shipment.status,
                    enroute_to: shipment.enroute_to));
              }
            }
            if (delivered.isNotEmpty) {
              ret.add(Text(
                "Delivered".toUpperCase(),
                style: GoogleFonts.openSans(
                    color: const Color(0xff464646),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ));
              ret.add(const SizedBox(
                height: 10,
              ));
              for (Shipment shipment in delivered) {
                ret.add(ShipmentItem(
                    shipmentId: shipment.id["\$oid"] ?? "",
                    name: "Name of item",
                    weight: shipment.totalWeight,
                    emission: shipment.emission,
                    status: shipment.status,
                    enroute_to: shipment.enroute_to));
              }
            }
            return Column(
              children: ret,
            );
          },
        ),
      ],
    );
  }
}
