import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/mazaj/mazaj_select.dart';
import 'package:sara_plant/provider/get_mazaj_all.dart';
import '../../components/error_get_data.dart';
import '../../provider/theme.dart';

class MazajHome extends StatefulWidget {
  const MazajHome({super.key});

  @override
  State<MazajHome> createState() => _MazaHomeState();
}

class _MazaHomeState extends State<MazajHome> {
  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    context.read<AllMazajGet>().fetchData;
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
                  Navigator.pop(context);
                }),
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(IconlyLight.arrow_left_2)))
          ],
          elevation: 0.0),
      body: listViewShow(),
    );
  }

  var show_data = [];
  var show_data_Search = [];

  Widget listViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Consumer<AllMazajGet>(builder: (context, value, child) {
      show_data = value.map;
      show_data_Search = value.map;
      return value.map.length == 0 && !value.error
          ? const My_loading()
          : value.error
              ? Text(value.errorMessage.toString())
              : ListView.builder(
                  itemCount: show_data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 3.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MazajSelectPage(
                                          property: show_data[index].property,
                                          proposalProperty:
                                              show_data[index].proposalProperty,
                                          characterProperty: show_data[index]
                                              .characterProperty,
                                          description:
                                              show_data[index].description,
                                        )));
                          },
                          child: AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            curve: Curves.easeInOut,
                            duration:
                                Duration(milliseconds: 300 + (index * 200)),
                            transform: Matrix4.translationValues(
                                startAnimation ? 0 : myWidth, 0, 0),
                            child: Text(show_data[index].name,
                                style: TextStyle(
                                    color: theme.text,
                                    fontWeight: FontWeight.bold)),
                          )),
                    );
                  },
                );
    });
  }
}
