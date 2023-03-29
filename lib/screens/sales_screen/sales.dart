import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_frontend/configs/palette.dart';
import 'package:sih_frontend/model/product.dart';
import 'package:sih_frontend/utils/ecotag_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  late TooltipBehavior _tooltipBehavior;

  List<ChartData> data = [];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    EcoTagAPI().stater(widget.product.categoryID).then((value) {
      Map m = value["states"];
      print(m);
      setState(() {
        m.forEach((k, v) {
          data.add(ChartData(k.toString().toUpperCase(), v.toDouble()));
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text("Analytics",
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            color: Palette.primaryDarkGreen,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  child: SfCircularChart(
                      tooltipBehavior: _tooltipBehavior,
                      annotations: <CircularChartAnnotation>[
                    // CircularChartAnnotation(
                    //     widget: Container(
                    //         child: PhysicalModel(
                    //             child: Container(),
                    //             shape: BoxShape.circle,
                    //             elevation: 10,
                    //             shadowColor: Colors.black,
                    //             color: const Color.fromRGBO(230, 230, 230, 1)))),
                    CircularChartAnnotation(
                        widget: Container(
                            child: const Text('Popularity',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    fontSize: 25))))
                  ],
                      series: <CircularSeries>[
                    // Render pie chart
                    DoughnutSeries<ChartData, String>(
                        dataSource: data,
                        radius: "180",
                        // pointColorMapper: (ChartData d, _) => d.,
                        enableTooltip: true,
                        dataLabelMapper: (ChartData data, _) => data.x,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        xValueMapper: (ChartData d, _) => d.x,
                        yValueMapper: (ChartData d, _) => d.y)
                  ])),
            ],
          ),
        )));
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
