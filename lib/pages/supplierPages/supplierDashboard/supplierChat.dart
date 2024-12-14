import 'package:flutter/material.dart';
import 'package:pavinet/customstyles/customStyles.dart';

class SupplierChat extends StatefulWidget {
  const SupplierChat({super.key});

  @override
  State<SupplierChat> createState() => _SupplierChatState();
}

class _SupplierChatState extends State<SupplierChat> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // text box container
                Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      padding: EdgeInsets.all(10),
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.multiline,
                            minLines:
                                1, //Normal textInputField will be displayed
                            maxLines:
                                5, // when user presses enter it will adapt to it
                          ),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 35),
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      style: CustomButtonStyle.button1,
                      onPressed: () {
                        print("SEND MESSAGE");
                      },
                      child: const Text(
                        'SEND',
                        style: CustomeTextStyle.txtWhiteBold,
                      )),
                ),
                // messages container
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: const Text(
                            'Chat',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataTable(dataRowMaxHeight: double.infinity, columns: [
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Messages'))
                        ], rows: [
                          DataRow(cells: [
                            DataCell(Text('21/10/24')),
                            DataCell(Text('Testing message length.')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('25/10/24')),
                            DataCell(Text(
                                'Dynamic Row Height for DataTable in Flutter.')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('26/10/24')),
                            DataCell(Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')),
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
