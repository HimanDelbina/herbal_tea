import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sara_plant/page/mazaj/quiz_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizPage()));
                  },
                  leading: const Text("تعیین مزاج"),
                  trailing: const Icon(IconlyBold.graph)),
              const Divider(),
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
