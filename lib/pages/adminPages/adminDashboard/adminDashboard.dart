import 'package:flutter/material.dart';
import 'package:pavinet/pages/adminPages/adminDashboard/adminChat.dart';
import 'package:pavinet/pages/adminPages/adminDashboard/adminMain.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Dashboard'),
          ),
          body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    child: TabBar(
                        labelColor: Colors.brown,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.brown,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          fontSize: 20.0,
                        ),
                        tabs: [
                          Tab(text: 'Main'),
                          Tab(text: 'Chat'),
                        ]),
                  ),
                  Expanded(
                      child: Container(
                    child: TabBarView(children: [
                      Container(
                        child: AdminMain(),
                      ),
                      Container(
                        child: AdminChat(),
                      ),
                    ]),
                  ))
                ],
              ))),
    );
  }
}
