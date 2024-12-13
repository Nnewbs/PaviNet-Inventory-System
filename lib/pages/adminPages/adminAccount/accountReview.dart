import 'package:flutter/material.dart';
import 'package:pavinet/pages/adminPages/adminAccount/staffReview.dart';
import 'package:pavinet/pages/adminPages/adminAccount/supplierReview.dart';

class AccountReview extends StatefulWidget {
  const AccountReview({super.key});

  @override
  State<AccountReview> createState() => _AccountReviewState();
}

class _AccountReviewState extends State<AccountReview> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Account Review'),
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
                          Tab(text: 'Staff'),
                          Tab(text: 'Supplier'),
                        ]),
                  ),
                  Expanded(
                      child: Container(
                    child: TabBarView(children: [
                      Container(
                        child: StaffReview(),
                      ),
                      Container(
                        child: SupplierReview(),
                      ),
                    ]),
                  ))
                ],
              ))),
    );
  }
}
