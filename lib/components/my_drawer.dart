import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sara_plant/page/mazaj/mazaj_home.dart';
import 'package:sara_plant/page/mazaj/quiz_page.dart';
import 'package:sara_plant/page/register/signup.dart';
import 'package:sara_plant/static/message_static.dart';

import '../static/shared_helper.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool is_signup = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                  tileColor: Colors.grey.withOpacity(0.1),
                  onTap: () {
                    // setState(() {
                    //   is_signup = true;
                    // });
                    if (SharedHelper.my_token == null) {
                      setState(() {
                        is_signup = true;
                      });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizPage()));
                    }
                  },
                  leading: const Text("تعیین مزاج"),
                  trailing: const Icon(IconlyBold.graph)),
              is_signup == false
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: const [
                            Text("لطفا"),
                            Text(
                              " ثبت نام ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            Text("کنید"),
                          ],
                        ),
                      )),
              const Divider(),
              ListTile(
                  tileColor: Colors.grey.withOpacity(0.1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MazajHome()));
                  },
                  leading: const Text("مزاج شناسی"),
                  trailing: const Icon(IconlyBold.graph)),
              const Spacer(),
              const Divider(),
              ListTile(
                  tileColor: Colors.grey.withOpacity(0.1),
                  onTap: () {
                    exit(0);
                  },
                  leading: const Text("خروج"),
                  trailing: const Icon(IconlyBold.logout))
            ],
          ),
        ),
      ),
    );
  }
}
