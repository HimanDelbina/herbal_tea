import 'package:flutter/material.dart';

class MyMessage {
  static void mySnackbarMessage(
      BuildContext context, String title, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        content: Text(title),
      ),
    );
  }
}
