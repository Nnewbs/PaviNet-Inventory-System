import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pavinet/customstyles/customStyles.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController msgController = TextEditingController();

  sendMessage(String message) async {
    FirebaseFirestore.instance.collection("message").doc(message).set({
      "Message": message,
    }).then((value) {
      print("Message sent.");
    });
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // text box container
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 40),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        child: Scrollbar(
                          child: TextField(
                            controller: msgController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.multiline,
                            minLines:
                                1, //Normal textInputField will be displayed
                            maxLines:
                                5, // when user presses enter it will adapt to it
                          ),
                        ),
                      ),
                      // send button
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            style: CustomButtonStyle.bgButton,
                            onPressed: () {
                              sendMessage(msgController.text.toString());
                              print("SEND MESSAGE");
                            },
                            child: const Text(
                              'SEND',
                              style: CustomeTextStyle.txtWhiteBold,
                            )),
                      )
                    ],
                  ),
                ),
                // chat container
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DataTable(dataRowMaxHeight: double.infinity, columns: [
                          DataColumn(
                            label: Text(
                              'Chats',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(label: Text(''))
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
          ),
        ));
  }
}
