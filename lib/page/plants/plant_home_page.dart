import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/icon_clicked.dart';
import 'package:sara_plant/components/my_search.dart';
import 'package:sara_plant/components/search_component.dart';
import 'package:sara_plant/static/user_static.dart';
import 'package:sara_plant/page/plants/plant_select_new.dart';
import 'package:sara_plant/provider/animation_controller.dart';
import '../../components/error_page.dart';
import '../../components/test_search.dart';
import '../../provider/get_plant.dart';
import '../../provider/theme.dart';
import '../../static/message_static.dart';
import '../../static/helper.dart';
import '../../static/shared_helper.dart';
import 'package:easy_localization/easy_localization.dart';

class PlantHome extends StatefulWidget {
  const PlantHome({Key? key}) : super(key: key);

  @override
  State<PlantHome> createState() => _PlantHomeState();
}

class _PlantHomeState extends State<PlantHome> {
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

  TextEditingController plant_search_controller = TextEditingController();

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
                keyboardType: TextInputType.text,
                controller: plant_search_controller,
                cursorColor: theme.cursorSearch,
                decoration: InputDecoration(
                    labelText: "serach".tr(),
                    hintText: "serach".tr(),
                    hintStyle: TextStyle(color: theme.unselectItem),
                    labelStyle: TextStyle(color: theme.text),
                    suffixIconColor: theme.iconItem,
                    suffixIcon: Icon(IconlyLight.search, color: theme.iconItem),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.focusBorderSearch)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.enableBorderSearch)),
                    border: const OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    show_data = SearchComponent.search(
                        show_data_Search, value, "plant");
                  });
                },
              ),
            ),
          ),
          Expanded(child: listViewShow())
        ],
      ),
    );
  }

  String select_image = "";
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
          plant_search_controller.text == ""
              ? show_data = value.map
              : show_data = show_data;
          show_data_Search = value.map;
          return value.map.length == 0 && !value.error
              ? const My_loading()
              : value.error
                  ? Text(value.errorMessage.toString())
                  : show_data.length != 0
                      ? ListView.builder(
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
                                  duration: Duration(
                                      milliseconds: 300 + (index * 200)),
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
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Center(
                                                  child: Image.network(
                                                    show_data[index].image ==
                                                            null
                                                        ? ""
                                                        : Helper.imageUrl +
                                                            show_data[index]
                                                                .image
                                                                .toString(),
                                                  ),
                                                ),
                                              ),
                                              const VerticalDivider(),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        show_data[index].name,
                                                        style: TextStyle(
                                                          color: theme.text,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        show_data[index]
                                                            .mazaj
                                                            .name,
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SliderPlant(value
                                                              .map[index]
                                                              .ranking!),
                                                          LikePlant(
                                                              show_data[index]),
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
                                      OurSuggestion(show_data[index]),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : ErrorPage(
                          image: "assets/animation/empty.json",
                          text: "null_search".tr(),
                          is_rich: false);
        });
      },
    );
  }

  Widget LikePlant(var data) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          setState(() {
            plant_id = data.id;
            select_image = Helper.imageUrl + data.image.toString();
          });
          SharedHelper.my_token != null && data.isLike == false
              ? save_plant()
              : data.isLike == true
                  ? delete_plant_faviorate()
                  : MyMessage.mySignUpMessage(
                      context, "complete_signUp".tr(), 1);
        },
        child: MyFaviorateIcon(is_fave: data.isLike == true));
  }

  Widget SliderPlant(double data) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SliderTheme(
        data: SliderThemeData(
            inactiveTrackColor: Colors.green.withOpacity(0.3),
            activeTrackColor: Colors.green,
            thumbColor: Colors.green,
            trackHeight: 1.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 1),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 1)),
        child: Container(
            width: myWidth * 0.2,
            child: Slider(
                value: data.toDouble(),
                onChanged: (value) {},
                min: 0,
                max: 5)));
  }

  Widget OurSuggestion(var data) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return data.ourSuggestion
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: myHeight * 0.025,
                width: myWidth * 0.05,
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0))),
                child: const Center(child: Icon(IconlyBold.star, size: 8.0)),
              )
            ],
          )
        : const SizedBox();
  }

  void save_plant() async {
    String url = Helper.url + "history/post_faviorate_plant";
    var body = json.encode({"user": UserStaticFile.user_id, "plant": plant_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessageWithImage(
          context, "add_plant_faviorate_complete".tr(), select_image, 1);
    } else {
      MyMessage.mySnackbarMessageWithImage(
          context, "add_plant_faviorate_already".tr(), select_image, 1);
    }
  }

  int? id_data_for_delete;

  void delete_plant_faviorate() async {
    String url = Helper.url + 'history/delete_faviorate_plant_user';
    var body = json.encode({"user": UserStaticFile.user_id, "plant": plant_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessageWithImage(
          context, "delete_complete".tr(), select_image, 1);
    } else {
      MyMessage.mySnackbarMessageWithImage(
          context, "delete_error".tr(), select_image, 1);
    }
  }
}
