import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// NOT USED, CAN BE DELETED LATER

class ColoredContainer extends StatefulWidget {
  const ColoredContainer({super.key});

  @override
  State<ColoredContainer> createState() => _ColoredContainerState();
}

class _ColoredContainerState extends State<ColoredContainer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      width: w / 2,
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0, 0.9],
          colors: [
            Color.fromARGB(255, 255, 101, 155),
            Color.fromARGB(255, 254, 147, 177),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/cloud.png",
                // color: Color.fromARGB(255, 0, 0, 0),
                // width: 50.0,
                // height: 50.0,
              ),
              const Text(
                "High",
                style: TextStyle(
                    // color: Colors.white,
                    fontFamily: "Acme",
                    fontSize: 30,
                    color: Color.fromARGB(255, 194, 19, 19)),
              ),
            ],
          ),
          const Text(
            "CO2 Emission",
            style: TextStyle(
                // color: Colors.white,
                fontFamily: "Acme",
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          const SizedBox(
            height: 3,
          ),
          const Text(
            "Improve now",
            style: TextStyle(
                // color: Colors.white,
                // fontFamily: "Acme",
                fontSize: 15,
                color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }
}
