import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/dashboard.dart';
import 'package:pavinet/pages/supplierPages/supplierHome/supplierMessages.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({super.key});

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
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
                    SupplierMessages(),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
