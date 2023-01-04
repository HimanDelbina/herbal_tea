import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../provider/theme.dart';
import '../start_page.dart';

class MazajDesPage extends StatefulWidget {
  var data;
  String? title;
  bool? is_title = false;
  MazajDesPage({super.key, this.data, this.title, this.is_title});

  @override
  State<MazajDesPage> createState() => _MazajDesPageState();
}

class _MazajDesPageState extends State<MazajDesPage> {
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
          centerTitle: true,
          title: Text(widget.title!),
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return widget.is_title!
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.data[index].description),
                      const Divider(color: Colors.green),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data[index].description),
                      const Divider(color: Colors.green),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
