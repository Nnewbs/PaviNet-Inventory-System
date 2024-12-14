import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SupplierMain extends StatefulWidget {
  const SupplierMain({super.key});

  @override
  State<SupplierMain> createState() => _SupplierMainState();
}

class _SupplierMainState extends State<SupplierMain> {
  @override
  Widget build(BuildContext content) {
    // static data sample
    final List<ChartData> chartData = [
      ChartData('Choc Moist', 19),
      ChartData('Choc Jar', 15),
      ChartData('Cendol', 18),
      ChartData('Tart', 15),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // stock level container
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            'Stock Level',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <CartesianSeries<ChartData, String>>[
                              // Renders column chart
                              ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, int index) =>
                                    data.x,
                                yValueMapper: (ChartData data, int index) =>
                                    data.y,
                              )
                            ]),
                      ],
                    )),
                SizedBox(height: 10),
                // best seller container
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            'Best Seller',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
