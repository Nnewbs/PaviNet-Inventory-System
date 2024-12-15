import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/adminPages/adminDashboard/adminDashboard.dart';
import 'package:pavinet/pages/adminPages/adminDashboard/adminMessage.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                        // Tab(text: 'History')
                      ]),

                  // ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    AdminDashboard(),
                    AdminMessages(),
                    // SupplierHistory(),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
