import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/page/sick/sick-natural_page.dart';
import 'package:sara_plant/page/sick/sick_sign_page.dart';
import '../../model/new/sick_select_model.dart';
import '../../provider/theme.dart';
import '../start_page.dart';
import 'package:easy_localization/easy_localization.dart';

class SickSelect extends StatefulWidget {
  var data;
  SickSelect({super.key, this.data});

  @override
  State<SickSelect> createState() => _SickSelectState();
}

class _SickSelectState extends State<SickSelect> {
  var sick_data;
  @override
  void initState() {
    super.initState();
    sick_data = widget.data;
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(sick_data.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                sick_data.sickDescription,
                textAlign: TextAlign.justify,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  item("disease_symptoms".tr(),
                      SickSignPage(data: sick_data.signsSick)),
                  item("natural_treatment".tr(),
                      SickNaturalPage(data: sick_data.nuturalSick)),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget item(String title, Widget widget) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Container(
        height: myHeight * 0.06,
        width: myWidth * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}
