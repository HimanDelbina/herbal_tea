import 'package:flutter/material.dart';

import '../page/register/signup.dart';

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

  static void mySignUpMessage(
      BuildContext context, String title, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: duration),
        action: SnackBarAction(
            label: "ثبت نام",
            // textColor: theme.text,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            }),
        content: Text(title)));
  }
}
