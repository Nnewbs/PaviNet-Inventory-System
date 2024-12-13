import 'package:flutter/material.dart';

class SupplierReview extends StatefulWidget {
  const SupplierReview({super.key});

  @override
  State<SupplierReview> createState() => _SupplierReviewState();
}

class _SupplierReviewState extends State<SupplierReview> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Supplier Account Review')],
        ),
      ),
    );
  }
}
