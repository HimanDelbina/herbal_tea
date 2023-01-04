import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/mazaj/mazaj_des.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(widget.description!,
                        style: const TextStyle(), textAlign: TextAlign.justify),
                  ],
                ),
              ),
              Container(
                height: myHeight * 0.2,
                width: myWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        item("ویژگی های ظاهری", widget.property, false, true),
                        item("ویژگی های شخصیتی", widget.characterProperty,
                            false, false),
                      ],
                    ),
                    item("پیشنهادات ", widget.proposalProperty, true, false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget item(String title, var data, bool is_width, bool is_title) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MazajDesPage(
                        data: data,
                        title: title,
                        is_title: is_title,
                      )));
        },
        child: Container(
          height: myHeight * 0.07,
          width: is_width ? myWidth : myWidth * 0.42,
          decoration: BoxDecoration(
            color: is_width
                ? Colors.amber.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                const Icon(IconlyBold.ticket_star)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
