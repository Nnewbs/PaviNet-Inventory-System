import 'package:flutter/material.dart';

class SupplierNotiPage extends StatefulWidget {
  const SupplierNotiPage({super.key});

  @override
  State<SupplierNotiPage> createState() => _SupplierNotiPageState();
}

class _SupplierNotiPageState extends State<SupplierNotiPage> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[const Text('Supplier Notification')],
            ),
          ),
        ));
  }
}
