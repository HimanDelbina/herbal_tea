import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/custom_transition.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/image_slider.dart';
import 'package:sara_plant/page/herbal_tea/herbalTea_home.dart';
import 'package:sara_plant/page/herbal_tea/herbaltea_select.dart';
import 'package:sara_plant/page/plants/plant_select_new.dart';
import 'package:sara_plant/page/sick/sick_home.dart';
import 'package:sara_plant/provider/get_herbaltea.dart';
import 'package:sara_plant/static/message_static.dart';
import '../../components/page_route.dart';
import '../../provider/get_plant.dart';
import '../../provider/theme.dart';
import '../../static/shared_helper.dart';
import '../plants/plant_home_page.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int is_exit = 0;

  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    SharedHelper.shared_get_token();
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
    context.read<PlantGet>().fetchData;
    context.read<HerbalTeaGet>().fetchData;
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 500), () {
          is_exit = 0;
        });
        is_exit++;
        if (is_exit == 2) {
          exit(1);
        } else {
          MyMessage.mySnackbarMessage(context, "for_exit".tr(), 1);
        }
        return false;
      },
      child: Container(
        height: myHeight,
        width: myWidth,
        color: theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Row(
                children: [
                  MyWidgetTransform(
                    duration: 600,
                    curve: Curves.easeIn,
                    child: header_Item_home("assets/image/leaf.png",
                        "plants".tr(), Colors.greenAccent.withOpacity(0.1), () {
                      Navigator.of(context).push(FadeInRoute(
                          page: const PlantHome(), routeName: "plant"));
                    }),
                  ),
                  MyWidgetTransform(
                    duration: 800,
                    curve: Curves.easeIn,
                    child: header_Item_home("assets/image/tea.png",
                        "herbaltea".tr(), Colors.brown.withOpacity(0.1), () {
                      Navigator.of(context).push(FadeInRoute(
                          page: const HerbalTeaHome(), routeName: "herbaltea"));
                    }),
                  ),
                  MyWidgetTransform(
                    duration: 1000,
                    curve: Curves.easeIn,
                    child: header_Item_home("assets/image/sick.png",
                        "sick".tr(), Colors.redAccent.withOpacity(0.1), () {
                      Navigator.of(context).push(FadeInRoute(
                          page: const SickHome(), routeName: "sick"));
                    }),
                  ),
                ],
              ),
              plantItem(),
              damNoshItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget header_Item_home(
      String image, String title, Color color, VoidCallback ontap) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          children: [
            Container(
              height: myHeight * 0.06,
              width: myWidth * 0.12,
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), color: color),
              child: Center(
                child: Image.asset(image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(title,
                  style: TextStyle(
                      color: theme.text,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget plantItem() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 15.0),
      child: Container(
        height: myHeight * 0.25,
        width: myWidth,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlantHome()));
                },
                child: Row(
                  children: [
                    Center(
                      child: Text("medicinal_plants".tr(),
                          style: TextStyle(
                            color: theme.titleText,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: listViewShow()),
          ],
        ),
      ),
    );
  }

  Widget damNoshItem() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Container(
      height: myHeight * 0.25,
      width: myWidth,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HerbalTeaHome()));
              },
              child: Row(
                children: [
                  Center(
                      child: Text("herbaltea".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.titleText))),
                ],
              ),
            ),
          ),
          Expanded(child: listViewDamnoshShow()),
        ],
      ),
    );
  }

  Widget listViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Consumer<PlantGet>(builder: (context, value, child) {
      return value.map.length == 0 && !value.error
          ? const My_loading()
          : value.error
              ? Text(value.errorMessage.toString())
              : ListView.builder(
                  itemCount: value.map.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlantSelectNew(
                                        id: value.map[index].id)));
                          },
                          child: AnimatedContainer(
                            height: myHeight * 0.15,
                            width: myWidth * 0.3,
                            curve: Curves.easeInOut,
                            duration:
                                Duration(milliseconds: 300 + (index * 200)),
                            transform: Matrix4.translationValues(
                                startAnimation ? 0 : myWidth, 0, 0),
                            decoration: BoxDecoration(
                                color: theme.items,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: myHeight * 0.08,
                                      width: myWidth * 0.16,
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.network(
                                          value.map[index].image == null
                                              ? ""
                                              : "http://swaaaa.ir:7777" +
                                                  value.map[index].image
                                                      .toString())),
                                  Text(value.map[index].name.toString(),
                                      style: TextStyle(
                                          color: theme.text,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
    });
  }

  Widget listViewDamnoshShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Consumer<HerbalTeaGet>(builder: (context, value, child) {
      return value.map.length == 0 && !value.error
          ? const My_loading()
          : value.error
              ? Text(value.errorMessage.toString())
              : ListView.builder(
                  itemCount: value.map.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HerbalTeaSelect(
                                        id: value.map[index].id)));
                          },
                          child: AnimatedContainer(
                            height: myHeight * 0.15,
                            width: myWidth * 0.3,
                            curve: Curves.easeInOut,
                            duration:
                                Duration(milliseconds: 300 + (index * 200)),
                            transform: Matrix4.translationValues(
                                startAnimation ? 0 : myWidth, 0, 0),
                            decoration: BoxDecoration(
                                color: theme.items,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: myHeight * 0.08,
                                    width: myWidth,
                                    padding: const EdgeInsets.all(5.0),
                                    child: ImageSliderHerbalTea(
                                        data: value.map[index].imageHerbaltea),
                                  ),
                                  Text(
                                    value.map[index].name.toString(),
                                    style: TextStyle(
                                        color: theme.text,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
    });
  }
}
