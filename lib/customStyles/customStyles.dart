import 'package:flutter/material.dart';

class CustomeTextStyle {
  static const TextStyle nameOfAppStyle =
      TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold);
  static const TextStyle SignUpLogin =
      TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold);
  static const TextStyle txtWhite = TextStyle(color: Colors.white);
  static const TextStyle txtWhiteBold =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  static const TextStyle txtGrey = TextStyle(color: Colors.grey);
  static const TextStyle accent = TextStyle(color: Colors.orange);
  static const TextStyle accentBold =
      TextStyle(color: Colors.orange, fontWeight: FontWeight.bold);
}

class CustomButtonStyle {
  static ButtonStyle button1 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.orange);
  static ButtonStyle button2 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 12, color: Colors.orange),
      backgroundColor: Colors.transparent);
}
