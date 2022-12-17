import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/start_page.dart';
import '../../provider/theme.dart';

class AnswerPage extends StatefulWidget {
  var data;
  AnswerPage({super.key, this.data});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  var my_data;
  String? select_mazaj = "";
  @override
  void initState() {
    super.initState();
    my_data = widget.data;
    check_mazaj();
  }

  void check_mazaj() {
    if (my_data["sard_tar"] > my_data["garm_khoshk"] &&
        my_data["sard_tar"] > my_data["garm_tar"] &&
        my_data["sard_tar"] > my_data["sard_khoshk"]) {
      setState(() {
        select_mazaj = "مزاج سرد وتر(بلغمی)";
      });
    } else if (my_data["garm_khoshk"] > my_data["sard_tar"] &&
        my_data["garm_khoshk"] > my_data["garm_tar"] &&
        my_data["garm_khoshk"] > my_data["sard_khoshk"]) {
      setState(() {
        select_mazaj = "مزاج گرم و خشک(صفراوی)";
      });
    } else if (my_data["garm_tar"] > my_data["sard_tar"] &&
        my_data["garm_tar"] > my_data["garm_khoshk"] &&
        my_data["garm_tar"] > my_data["sard_khoshk"]) {
      setState(() {
        select_mazaj = "مزاج گرم وتر(دموی)";
      });
    } else if (my_data["sard_khoshk"] > my_data["sard_tar"] &&
        my_data["sard_khoshk"] > my_data["garm_khoshk"] &&
        my_data["sard_khoshk"] > my_data["garm_tar"]) {
      setState(() {
        select_mazaj = "مزاج سرد و خشک(سوداوی)";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: [
              mazaj_show(my_data["sard_tar"], "مزاج سرد وتر(بلغمی)"),
              mazaj_show(my_data["garm_khoshk"], "مزاج گرم و خشک(صفراوی)"),
              mazaj_show(my_data["garm_tar"], "مزاج گرم وتر(دموی)"),
              mazaj_show(my_data["sard_khoshk"], "مزاج سرد و خشک(سوداوی)"),
              const Spacer(),
              Text(select_mazaj!),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartPage()));
                },
                child: Container(
                  height: myHeight * 0.08,
                  width: myWidth,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Center(child: Text("تایید")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mazaj_show(int data, String title) {
    double? final_data;
    final_data = (data * 100 / 7);
    String show = final_data.toStringAsFixed(2);
    Color color = Colors.grey.withOpacity(0.1);
    IconData icon = IconlyBold.close_square;
    Color icon_color = Colors.grey.withOpacity(0.1);
    if (final_data > 50) {
      setState(() {
        color = Colors.greenAccent.withOpacity(0.3);
        icon = IconlyBold.tick_square;
        // select_mazaj = final_data.toString();
        icon_color = Colors.black;
      });
      // if (data == 0) {
      //   setState(() {
      //     select_mazaj = "مزاج سرد و تر";
      //   });
      // } else if (data == 1) {
      //   setState(() {
      //     select_mazaj = "مزاج گرم و خشک";
      //   });
      // } else if (data == 2) {
      //   setState(() {
      //     select_mazaj = "مزاج گرم و تر";
      //   });
      // } else if (data == 3) {
      //   setState(() {
      //     select_mazaj = "مزاج سرد و خشک";
      //   });
      // }
    } else if (final_data > 40) {
      setState(() {
        color = Colors.amberAccent.withOpacity(0.3);
        icon = IconlyBold.more_square;
        // select_mazaj = final_data.toString();
        icon_color = Colors.black;
      });
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        tileColor: color,
        title: Text(title),
        trailing: Text(show + "%"),
        leading: Icon(icon, color: icon_color),
      ),
    );
  }
}
