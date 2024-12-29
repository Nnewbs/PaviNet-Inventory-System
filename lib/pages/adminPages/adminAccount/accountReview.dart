import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/adminPages/adminAccount/staffReview.dart';
import 'package:pavinet/pages/adminPages/adminAccount/supplierReview.dart';

class AccountReview extends StatefulWidget {
  const AccountReview({super.key});

  @override
  State<AccountReview> createState() => _AccountReviewState();
}

class _AccountReviewState extends State<AccountReview> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Account Review',
            style: CustomeTextStyle.txtWhiteBold,
          ),
          backgroundColor: Colors.black,
          elevation: 5,
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.orange[700],
                    labelColor: Colors.orange[700],
                    unselectedLabelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.people),
                        text: 'Staff',
                      ),
                      Tab(
                        icon: Icon(Icons.business),
                        text: 'Supplier',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search accounts...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  StaffReview(searchQuery: searchQuery),
                  SupplierReview(searchQuery: searchQuery),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
