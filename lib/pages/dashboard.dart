import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<ChartData>> _chartDataFuture;
  late Future<List<DataRow>> _bestSellersFuture;

  @override
  void initState() {
    super.initState();
    _chartDataFuture = _fetchChartData();
    _bestSellersFuture = _fetchBestSellers();
  }

  Future<List<ChartData>> _fetchChartData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('items').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return ChartData(data['title'], data['quantity']);
    }).toList();
  }

  Future<List<DataRow>> _fetchBestSellers() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('items').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return DataRow(cells: [
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['title'], style: TextStyle(fontWeight: FontWeight.bold)),
            Text(data['price'],
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ],
        )),
        DataCell(Text('${data['quantity']} sold')),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Stock level container
              FutureBuilder<List<ChartData>>(
                future: _chartDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final chartData = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                            ColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              // Best sellers container
              FutureBuilder<List<DataRow>>(
                future: _bestSellersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final bestSellers = snapshot.data!;
                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(label: Text('')),
                          ],
                          rows: bestSellers,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
