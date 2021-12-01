import 'package:flutter/material.dart';

abstract class LoginStyle {
  static const TextStyle loginText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 23,
  );
}

abstract class Customs {
  static Widget button(
      String text, dynamic onClick, MaterialStateProperty<Color> color) {
    return TextButton(
      style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all<Size>(const Size(double.infinity, 30)),
          backgroundColor: color,
          foregroundColor: MaterialStateProperty.all(Colors.white)),
      onPressed: onClick,
      child: Padding(padding: const EdgeInsets.all(8), child: Text(text)),
    );
  }

  static PreferredSizeWidget appBar(String texto) {
    return AppBar(
      elevation: 0, // 1
      backgroundColor: Colors.transparent,
      title: Text(texto),
      centerTitle: true,
    );
  }
}
