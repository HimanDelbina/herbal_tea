import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/icon_clicked.dart';
import 'package:sara_plant/components/my_search.dart';
import 'package:sara_plant/page/herbal_tea/herbaltea_select.dart';
import 'package:sara_plant/provider/get_herbaltea.dart';
import 'package:sara_plant/static/message_static.dart';
import '../../components/error_get_data.dart';
import '../../components/image_slider.dart';
import '../../static/helper.dart';
import '../../static/shared_helper.dart';
import '../../static/user_static.dart';
import '../../provider/theme.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class HerbalTeaHome extends StatefulWidget {
  const HerbalTeaHome({Key? key}) : super(key: key);

  @override
  State<HerbalTeaHome> createState() => _HerbalTeaHomeState();
}

class _HerbalTeaHomeState extends State<HerbalTeaHome> {
  List show_data_image_final = [];

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
    context.read<HerbalTeaGet>().fetchData;
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
        body: SafeArea(
          child: Column(
            children: [
              MySearch(data: show_data, backup_data: show_data_Search),
              Expanded(child: listViewShow()),
            ],
          ),
        ));
  }

  var show_data = [];
  var show_data_image = [];
  var show_data_Search = [];
  String image_select = '';
  Widget listViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Consumer<HerbalTeaGet>(builder: (context, value, child) {
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
                                    builder: (context) => HerbalTeaSelect(
                                        id: show_data[index].id)));
                          },
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            curve: Curves.easeInOut,
                            duration:
                                Duration(milliseconds: 300 + (index * 200)),
                            transform: Matrix4.translationValues(
                                startAnimation ? 0 : myWidth, 0, 0),
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
                                              child: ImageSliderHerbalTea(
                                            data:
                                                value.map[index].imageHerbaltea,
                                          )),
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
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(show_data[index].name,
                                                    style: TextStyle(
                                                        color: theme.text,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "قیمت : " +
                                                            show_data[index]
                                                                .price
                                                                .toStringAsFixed(
                                                                    0)
                                                                .toString()
                                                                .toPersianDigit()
                                                                .seRagham(),
                                                        style: TextStyle(
                                                            color: theme.text)),
                                                    Row(
                                                      children: [
                                                        AddToCartHerbalTea(
                                                            show_data[index],
                                                            value.map[index]),
                                                        const SizedBox(
                                                            width: 10.0),
                                                        LikeHerbalTea(
                                                            show_data[index],
                                                            value.map[index]),
                                                      ],
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
                                OurSuggestion(show_data[index]),
                              ],
                            ),
                          )),
                    );
                  },
                );
    });
  }

  Widget LikeHerbalTea(var data, var image_data) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          setState(() {
            herbaltea_id = data.id;
            image_select = '';
            image_data.imageHerbaltea!.length == 0
                ? ""
                : image_select = Helper.imageUrl +
                    image_data.imageHerbaltea![0].image.toString();
          });
          SharedHelper.my_token != null && data.isLike == false
              ? save_herbaltea()
              : data.isLike == true
                  ? delete_herbaltea_faviorate()
                  : MyMessage.mySignUpMessage(
                      context, "لطفا اول ثبت نام کنید", 1);
        },
        child: MyFaviorateIcon(is_fave: data.isLike == true));
  }

  Widget AddToCartHerbalTea(var data, var image_data) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          setState(() {
            herbaltea_id = data.id;
            image_select = '';
            image_data.imageHerbaltea!.length == 0
                ? ""
                : image_select = Helper.imageUrl +
                    image_data.imageHerbaltea![0].image.toString();
          });
          if (SharedHelper.my_token != null) {
            add_to_card();
          }
        },
        child: const Icon(IconlyLight.bag));
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

  int? herbaltea_id;
  void save_herbaltea() async {
    String url = Helper.url + "history/post_faviorate_herbaltea";
    var body = json
        .encode({"user": UserStaticFile.user_id!, "herbaltea": herbaltea_id});
    var res = await Helper.postApi(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessageWithImage(
          context, 'دمنوش به لیست مورد علاقه ها اضافه شد', image_select, 1);
    } else if ((res.statusCode == 208)) {
      MyMessage.mySnackbarMessageWithImage(context,
          'این دمنوش قبلا به لیست مورد علاقه ها اضافه شده', image_select, 1);
    } else {
      MyMessage.mySnackbarMessage(
          context, 'در حال حاضر خطایی رخ داده لطفا بعدا امتحان کنید', 1);
    }
  }

  void add_to_card() async {
    String url = Helper.url + "card/post_herbalTea_card";
    var body = json
        .encode({"user": UserStaticFile.user_id!, "herbal_tea": herbaltea_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessageWithImage(
          context, 'دمنوش به سبد خرید اضافه شد', image_select, 1);
    } else if ((res.statusCode == 208)) {
      MyMessage.mySnackbarMessageWithImage(
          context, 'این دمنوش قبلا به سبد خرید اضافه شده', image_select, 1);
    } else {
      MyMessage.mySnackbarMessage(
          context, 'در حال حاضر خطایی رخ داده لطفا بعدا امتحان کنید', 1);
    }
  }

  void delete_herbaltea_faviorate() async {
    String url = Helper.url + 'history/delete_faviorate_herbaltea_user';
    var body = json
        .encode({"user": UserStaticFile.user_id!, "herbaltea": herbaltea_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessageWithImage(
          context, 'با موفقیت از لیست حذف شد', image_select, 1);
    } else {
      MyMessage.mySnackbarMessageWithImage(
          context, 'متاسفانه از لیست حذف نشد', image_select, 1);
    }
  }
}
