import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class SupplierHistory extends StatefulWidget {
  const SupplierHistory({super.key});

  @override
  State<SupplierHistory> createState() => _SupplierHistoryState();
}

class _SupplierHistoryState extends State<SupplierHistory> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              // order history container
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: const Text(
                        'Order History',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // static data sample
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: DataTable(
                              dataRowMaxHeight: double.infinity,
                              columns: [
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('Item Name')),
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('Status'))
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('21/10/24')),
                                  DataCell(Text('Choco Moist Cake')),
                                  DataCell(Text('3')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Approved',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('25/10/24')),
                                  DataCell(Text('Tart')),
                                  DataCell(Text('5')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.yellowAccent[700],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Pending',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('26/10/24')),
                                  DataCell(Text('Choco Jar')),
                                  DataCell(Text('6')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Rejected',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('21/10/24')),
                                  DataCell(Text('Choco Moist Cake')),
                                  DataCell(Text('3')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Approved',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('25/10/24')),
                                  DataCell(Text('Tart')),
                                  DataCell(Text('5')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.yellowAccent[700],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Pending',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('26/10/24')),
                                  DataCell(Text('Choco Jar')),
                                  DataCell(Text('6')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Rejected',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('21/10/24')),
                                  DataCell(Text('Choco Moist Cake')),
                                  DataCell(Text('3')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Approved',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('25/10/24')),
                                  DataCell(Text('Tart')),
                                  DataCell(Text('5')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.yellowAccent[700],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Pending',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('26/10/24')),
                                  DataCell(Text('Choco Jar')),
                                  DataCell(Text('6')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Rejected',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('21/10/24')),
                                  DataCell(Text('Choco Moist Cake')),
                                  DataCell(Text('3')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Approved',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  )),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('25/10/24')),
                                  DataCell(Text('Tart')),
                                  DataCell(Text('5')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.yellowAccent[700],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Pending',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('26/10/24')),
                                  DataCell(Text('Choco Jar')),
                                  DataCell(Text('6')),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Rejected',
                                      style: CustomeTextStyle.txtWhiteBold,
                                    ),
                                  ))
                                ]),
                              ])),
                    )
                  ]))
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
