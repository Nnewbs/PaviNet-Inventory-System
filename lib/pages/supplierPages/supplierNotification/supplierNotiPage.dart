import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class SupplierNotiPage extends StatefulWidget {
  const SupplierNotiPage({super.key});

  @override
  State<SupplierNotiPage> createState() => _SupplierNotiPageState();
}

class _SupplierNotiPageState extends State<SupplierNotiPage> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Notification',
              style: CustomeTextStyle.txtWhiteBold,
            ),
            backgroundColor: Colors.black,
          ),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                // notification container
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      // static data sample
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: DataTable(
                                dataRowMaxHeight: double.infinity,
                                columns: [
                                  DataColumn(label: Text('Item')),
                                  DataColumn(label: Text('Quantity')),
                                  DataColumn(label: Text('Message')),
                                  // DataColumn(label: Text('Mark as Read'))
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('21/10/24')),
                                    DataCell(Text('3')),
                                    DataCell(ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 100), //SET max width
                                        child: Text(
                                          'very long text blah blah blah blah blah blah',
                                        ))),
                                  ]),
                                ])),
                      )
                    ]))
              ],
            ),
          ),
        ));
  }
}
