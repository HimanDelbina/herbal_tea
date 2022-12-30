import 'package:flutter/material.dart';
import '../page/register/signup.dart';

class MyMessage {
  static void mySnackbarMessage(
      BuildContext context, String title, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        content: Text(title, style: const TextStyle(fontFamily: "Vazir")),
      ),
    );
  }

  static void mazajHelperMessage(
      BuildContext context, String title, int duration) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        content: Container(
          height: myHeight * 0.3,
          width: myWidth,
          child: Column(
            children: [
              Row(
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontFamily: "Vazir", fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: myHeight * 0.03,
                    width: myWidth * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  const VerticalDivider(color: Colors.white),
                  const Expanded(
                      child: Text("به معنی تایید نهایی",
                          style: TextStyle(fontFamily: "Vazir"))),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: myHeight * 0.03,
                    width: myWidth * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  const VerticalDivider(color: Colors.white),
                  const Expanded(
                      child: Text("به معنی تشخیص ضعیف",
                          style: TextStyle(fontFamily: "Vazir"))),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    height: myHeight * 0.03,
                    width: myWidth * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  const VerticalDivider(color: Colors.white),
                  const Expanded(
                      child: Text("به معنی عدم تشخیص درست",
                          style: TextStyle(fontFamily: "Vazir"))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void mySnackbarMessageWithImage(
      BuildContext context, String title, String image, int duration) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontFamily: "Vazir")),
            image == ""
                ? const SizedBox()
                : Container(
                    height: myHeight * 0.05,
                    width: myWidth * 0.1,
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(image)),
          ],
        ),
      ),
    );
  }

  static void mySignUpMessage(
      BuildContext context, String title, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: duration),
        action: SnackBarAction(
            label: "ثبت نام",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            }),
        content: Text(title, style: const TextStyle(fontFamily: "Vazir"))));
  }

  static void myMessageChatBot(
      BuildContext context, String title, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: duration),
        action: SnackBarAction(
            label: "ثبت نام",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            }),
        content: Text(title, style: const TextStyle(fontFamily: "Vazir"))));
  }
}
