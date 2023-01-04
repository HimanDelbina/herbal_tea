import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/faviorate/faviorate_herbaltea.dart';
import 'package:sara_plant/page/faviorate/faviorate_plant.dart';
import 'package:sara_plant/page/faviorate/faviorate_sick.dart';
import '../../provider/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class FavioratePage extends StatefulWidget {
  const FavioratePage({Key? key}) : super(key: key);

  @override
  State<FavioratePage> createState() => _FavioratePageState();
}

class _FavioratePageState extends State<FavioratePage> {
  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                labelColor: theme.appbatTextSelect,
                unselectedLabelColor: theme.appbatTextUnselect,
                indicatorColor: theme.appbatTextSelect,
                tabs: [
                  tab_item("plants".tr()),
                  tab_item("herbaltea".tr()),
                  tab_item("sick".tr()),
                ],
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FavioratePlant(),
            FaviorateHerbalTea(),
            FaviorateSick(),
          ],
        ),
      ),
    );
  }

  Widget tab_item(String title) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0), child: Text(title));
  }
}
