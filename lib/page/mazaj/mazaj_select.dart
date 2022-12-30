import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/home/home.dart';
import 'package:sara_plant/page/start_page.dart';

import '../../provider/theme.dart';

class MazajSelectPage extends StatefulWidget {
  var property;
  var proposalProperty;
  var characterProperty;
  String? description;
  MazajSelectPage(
      {super.key,
      this.property,
      this.proposalProperty,
      this.characterProperty,
      this.description});

  @override
  State<MazajSelectPage> createState() => _MazajSelectPageState();
}

class _MazajSelectPageState extends State<MazajSelectPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: theme.iconItem),
          backgroundColor: Colors.transparent,
          leadingWidth: myWidth * 0.2,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartPage()));
                }),
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(IconlyBold.home))),
            const Spacer(),
            GestureDetector(
                onTap: (() {
                  Navigator.pop(context);
                }),
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(IconlyLight.arrow_left_2))),
          ],
          elevation: 0.0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            Text(
              widget.description!,
              style: TextStyle(),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
