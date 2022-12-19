import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/icon_clicked.dart';
import 'package:sara_plant/components/search_component.dart';
import 'package:sara_plant/static/user_static.dart';
import 'package:sara_plant/page/plants/plant_select_new.dart';
import 'package:sara_plant/page/register/signup.dart';
import 'package:sara_plant/provider/animation_controller.dart';
import '../../provider/get_plant.dart';
import '../../provider/theme.dart';
import '../../static/component_static.dart';
import '../../static/helper.dart';
import '../../static/shared_helper.dart';

class PlantHome extends StatefulWidget {
  const PlantHome({Key? key}) : super(key: key);

  @override
  State<PlantHome> createState() => _PlantHomeState();
}

class _PlantHomeState extends State<PlantHome> {
  void signup_erro_message() {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: "ثبت نام",
            textColor: theme.text,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            }),
        content: const Text('لطفا اول ثبت نام کنید')));
  }

  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
    listenercontroller.addListener(onListenerController);
  }

  final listenercontroller = ScrollController();
  void onListenerController() {
    setState(() {});
  }

  @override
  void dispose() {
    listenercontroller.removeListener(onListenerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    context.read<PlantGet>().fetchData;
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Container(
              height: myHeight * 0.07,
              child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      show_data = SearchComponent.search(
                          show_data_Search, value, "name");
                    });
                  },
                  cursorColor: theme.cursorSearch,
                  decoration: InputDecoration(
                      labelText: "جستجو",
                      hintText: "جستجو",
                      hintStyle: TextStyle(color: theme.unselectItem),
                      labelStyle: TextStyle(color: theme.text),
                      suffixIconColor: theme.iconItem,
                      suffixIcon:
                          Icon(IconlyLight.search, color: theme.iconItem),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.focusBorderSearch)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.enableBorderSearch)),
                      border: const OutlineInputBorder())),
            ),
          ),
          Expanded(child: listViewShow())
        ],
      ),
    );
  }

  Widget iconItemShow(double height, double width, String image, Color color,
      VoidCallback ontap) {
    return GestureDetector(
        onTap: ontap,
        child: Image.asset(image, height: height, width: width, color: color));
  }

  var show_data = [];
  var show_data_Search = [];
  int plant_id = 0;
  final MyAnimationController controller = MyAnimationController();
  Widget listViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    double my_size = myHeight * 0.1;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Consumer<PlantGet>(builder: (context, value, child) {
          show_data = value.map;
          show_data_Search = value.map;
          return value.map.length == 0 && !value.error
              ? const My_loading()
              : value.error
                  ? Text(value.errorMessage.toString())
                  : ListView.builder(
                      controller: listenercontroller,
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
                                      builder: (context) => PlantSelectNew(
                                          id: show_data[index].id)));
                            },
                            child: AnimatedContainer(
                              curve: Curves.easeInOut,
                              duration:
                                  Duration(milliseconds: 300 + (index * 200)),
                              transform: Matrix4.translationValues(
                                  startAnimation ? 0 : myWidth, 0, 0),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 7.0),
                                    child: Container(
                                      height: myHeight * 0.1,
                                      width: myWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: myHeight,
                                            width: myWidth * 0.2,
                                            padding: const EdgeInsets.all(7.0),
                                            child: Center(
                                              child: Image.network(
                                                  show_data[index].image == null
                                                      ? ""
                                                      : Helper.imageUrl +
                                                          show_data[index]
                                                              .image
                                                              .toString()),
                                            ),
                                          ),
                                          const VerticalDivider(),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(show_data[index].name,
                                                      style: TextStyle(
                                                          color: theme.text,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      show_data[index]
                                                          .mazaj
                                                          .name,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12.0)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SliderTheme(
                                                          data: SliderThemeData(
                                                              inactiveTrackColor:
                                                                  Colors.green
                                                                      .withOpacity(
                                                                          0.3),
                                                              activeTrackColor:
                                                                  Colors.green,
                                                              thumbColor:
                                                                  Colors.green,
                                                              trackHeight: 1.0,
                                                              thumbShape:
                                                                  const RoundSliderThumbShape(
                                                                      enabledThumbRadius:
                                                                          1),
                                                              overlayShape:
                                                                  const RoundSliderOverlayShape(
                                                                      overlayRadius:
                                                                          1)),
                                                          child: Container(
                                                              width:
                                                                  myWidth * 0.2,
                                                              child: Slider(
                                                                  value: value
                                                                      .map[
                                                                          index]
                                                                      .ranking!
                                                                      .toDouble(),
                                                                  onChanged:
                                                                      (value) {},
                                                                  min: 0,
                                                                  max: 5))),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            plant_id =
                                                                show_data[index]
                                                                    .id;
                                                          });
                                                          SharedHelper.my_token !=
                                                                      null &&
                                                                  show_data[index]
                                                                          .isLike ==
                                                                      false
                                                              ? save_plant()
                                                              : show_data[index]
                                                                          .isLike ==
                                                                      true
                                                                  ? delete_plant_faviorate()
                                                                  : signup_erro_message();
                                                        },
                                                        child: MyFaviorateIcon(
                                                            is_fave: show_data[
                                                                        index]
                                                                    .isLike ==
                                                                true),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  show_data[index].ourSuggestion
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: myHeight * 0.025,
                                              width: myWidth * 0.05,
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              decoration: const BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5.0))),
                                              child: const Center(
                                                child: Icon(IconlyBold.star,
                                                    size: 8.0),
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
        });
      },
    );
  }

  void save_plant() async {
    String url = Helper.url + "history/post_faviorate_plant";
    var body = json.encode({"user": UserStaticFile.user_id, "plant": plant_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessage(
          context, 'گیاه به لیست مورد علاقه ها اضافه شد', 1);
    } else {
      MyMessage.mySnackbarMessage(
          context, 'این گیاه قبلا به لیست مورد علاقه ها اضافه شده', 1);
    }
  }

  int? id_data_for_delete;

  void delete_plant_faviorate() async {
    String url = Helper.url + 'history/delete_faviorate_plant_user';
    var body = json.encode({"user": UserStaticFile.user_id, "plant": plant_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessage(context, 'با موفقیت از لیست حذف شد', 1);
    } else {
      MyMessage.mySnackbarMessage(context, 'متاسفانه از لیست حذف نشد', 1);
    }
  }
}
