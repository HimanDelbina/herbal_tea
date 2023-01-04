import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../provider/theme.dart';
import '../start_page.dart';

class SickNaturalPage extends StatefulWidget {
  var data;
  SickNaturalPage({super.key, this.data});

  @override
  State<SickNaturalPage> createState() => _SickNaturalPageState();
}

class _SickNaturalPageState extends State<SickNaturalPage> {
  var data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(data[index].title),
              );
            },
          ),
        ));
  }
}
