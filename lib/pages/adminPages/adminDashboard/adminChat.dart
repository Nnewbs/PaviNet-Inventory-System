import 'package:flutter/material.dart';

class AdminChat extends StatefulWidget {
  const AdminChat({super.key});

  @override
  State<AdminChat> createState() => _AdminChatState();
}

class _AdminChatState extends State<AdminChat> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Admin Dashboard Chat')],
        ),
      ),
    );
  }
}
