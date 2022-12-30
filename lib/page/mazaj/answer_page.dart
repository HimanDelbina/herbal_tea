import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/start_page.dart';
import '../../provider/theme.dart';
import '../../static/message_static.dart';

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
        select_mazaj = "مزاج سرد وتر (بلغمی)";
      });
    } else if (my_data["garm_khoshk"] > my_data["sard_tar"] &&
        my_data["garm_khoshk"] > my_data["garm_tar"] &&
        my_data["garm_khoshk"] > my_data["sard_khoshk"]) {
      setState(() {
        select_mazaj = "مزاج گرم و خشک (صفراوی)";
      });
    } else if (my_data["garm_tar"] > my_data["sard_tar"] &&
        my_data["garm_tar"] > my_data["garm_khoshk"] &&
        my_data["garm_tar"] > my_data["sard_khoshk"]) {
      setState(() {
        select_mazaj = "مزاج گرم وتر (دموی)";
      });
    } else if (my_data["sard_khoshk"] > my_data["sard_tar"] &&
        my_data["sard_khoshk"] > my_data["garm_khoshk"] &&
        my_data["sard_khoshk"] > my_data["garm_tar"]) {
      setState(() {
        select_mazaj = "مزاج سرد و خشک (سوداوی)";
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
              const Divider(),
              help_mazaj(),
              const Spacer(),
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

  Widget help_mazaj() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: myWidth,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " هوش مصنوعی ما مزاج شما را " +
                  select_mazaj! +
                  " تشخیص داده است " +
                  "لطفا قبل از تایید راهنمایی را مطالعه کنید",
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    MyMessage.mazajHelperMessage(context, "راهنمایی", 5);
                  },
                  child: const Text("راهنمایی",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartPage()));
                  },
                  child: const Text("خروج",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
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
        icon_color = Colors.black;
      });
    } else if (final_data > 40) {
      setState(() {
        color = Colors.amberAccent.withOpacity(0.3);
        icon = IconlyBold.more_square;
        icon_color = Colors.black;
      });
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        tileColor: color,
        title: Text(title, style: const TextStyle(fontSize: 14.0)),
        trailing: Text(show + "%", style: const TextStyle(fontSize: 14.0)),
        leading: Icon(icon, color: icon_color),
      ),
    );
  }
}
