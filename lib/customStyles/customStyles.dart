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
  static ButtonStyle bgButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.orange);
  static ButtonStyle txtButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 12, color: Colors.orange),
      backgroundColor: Colors.transparent);
}

class CustomTextFieldStyle {
  static const Color fillColor = Color(0xFFEEEEEE); // Light grey background
  static const Color hintTextColor =
      Color(0xFF9E9E9E); // Darker grey placeholder text

  static const InputDecoration textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: fillColor,
    hintStyle: TextStyle(color: hintTextColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  );
}
