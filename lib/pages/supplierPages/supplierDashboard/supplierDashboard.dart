import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SupplierDashboard extends StatefulWidget {
  const SupplierDashboard({super.key});

  @override
  State<SupplierDashboard> createState() => _SupplierDashboardState();
}

class _SupplierDashboardState extends State<SupplierDashboard> {
  @override
  Widget build(BuildContext content) {
    // static data sample
    final List<ChartData> chartData = [
      ChartData('Choco Moist', 19),
      ChartData('Choco Jar', 15),
      ChartData('Cendol', 18),
      ChartData('Tart', 15),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                            ),
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
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DataTable(
                            dividerThickness: 0.00000000001,
                            dataRowMaxHeight: double.infinity,
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Best Sellers',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(label: Text('')),
                            ],
                            // sample
                            rows: [
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Choco Moist',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM8.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('9 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tart',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM5.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('5 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Choco Jar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM12.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('6 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Choco Moist',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM8.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('9 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tart',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM5.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('5 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Choco Jar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM12.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('6 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Choco Moist',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM8.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('9 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tart',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM5.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('5 sold')),
                              ]),
                              DataRow(cells: [
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Choco Jar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('RM12.00',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                DataCell(Text('6 sold')),
                              ]),
                            ])
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
