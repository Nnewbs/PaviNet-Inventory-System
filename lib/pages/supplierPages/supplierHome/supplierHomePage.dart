import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/chat.dart';
import 'package:pavinet/pages/dashboard.dart';

class SupplierHome extends StatefulWidget {
  const SupplierHome({super.key});

  @override
  State<SupplierHome> createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<SupplierHome> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home',
            style: CustomeTextStyle.txtWhiteBold,
          ),
          backgroundColor: Colors.black,
        ),
        body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.orange[700],
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                        fontSize: 14.0,
                      ),
                      unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                      tabs: [
                        Tab(text: 'Dashboard'),
                        Tab(text: 'Messages'),
                      ]),
                ),
                Expanded(
                  child: TabBarView(children: [
                    Dashboard(),
                    Chat(),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
