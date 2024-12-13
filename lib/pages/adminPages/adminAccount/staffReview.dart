import 'package:flutter/material.dart';

class StaffReview extends StatefulWidget {
  const StaffReview({super.key});

  @override
  State<StaffReview> createState() => _StaffReviewState();
}

class _StaffReviewState extends State<StaffReview> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Staff Account Review')],
        ),
      ),
    );
  }
}
