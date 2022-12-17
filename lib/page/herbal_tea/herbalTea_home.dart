import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/helper.dart';
import 'package:sara_plant/components/icon_clicked.dart';
import 'package:sara_plant/components/shared_helper.dart';
import 'package:sara_plant/page/herbal_tea/herbaltea_select.dart';
import 'package:sara_plant/provider/get_herbaltea.dart';
import '../../components/error_get_data.dart';
import '../../components/image_slider.dart';
import '../../components/search_component.dart';
import '../../components/user_static.dart';
import '../../provider/theme.dart';
import '../register/signup.dart';
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
              Expanded(child: listViewShow()),
            ],
          ),
        ));
  }

  var show_data = [];
  var show_data_image = [];
  var show_data_Search = [];

  Widget listViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Consumer<HerbalTeaGet>(builder: (context, value, child) {
      show_data = value.map;
      show_data_Search = value.map;
      return value.map.length == 0 && !value.error
          ? const ErrorGetData()
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
                                                                .toString()
                                                                .toPersianDigit()
                                                                .seRagham(),
                                                        style: TextStyle(
                                                            color: theme.text)),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {},
                                                            child: const Icon(
                                                                IconlyLight
                                                                    .bag)),
                                                        const SizedBox(
                                                            width: 10.0),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              herbaltea_id =
                                                                  show_data[
                                                                          index]
                                                                      .id;
                                                            });
                                                            SharedHelper.my_token !=
                                                                        null &&
                                                                    show_data[index]
                                                                            .isLike ==
                                                                        false
                                                                ? save_herbaltea()
                                                                : show_data[index]
                                                                            .isLike ==
                                                                        true
                                                                    ? delete_herbaltea_faviorate()
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
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: const BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0))),
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
                          )),
                    );
                  },
                );
    });
  }

  void create_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('دمنوش به لیست مورد علاقه ها اضافه شد')));
  }

  void already_create_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 160, 0, 0),
        content: Text('این دمنوش قبلا به لیست مورد علاقه ها اضافه شده')));
  }

  void error_create_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 160, 0, 0),
        content: Text('در حال حاضر خطایی رخ داده لطفا بعدا امتحان کنید')));
  }

  int? herbaltea_id;
  void save_herbaltea() async {
    String url = Helper.url + "history/post_faviorate_herbaltea";
    var body = json
        .encode({"user": UserStaticFile.user_id!, "herbaltea": herbaltea_id});
    var res = await Helper.postApi(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      create_favorite();
    } else if ((res.statusCode == 208)) {
      already_create_favorite();
    } else {
      error_create_favorite();
    }
  }

// {
//     "id": 1,
//     "count": 2,
//     "is_price": false,
//     "create_at": "2022-12-17T22:19:08.334856+03:30",
//     "user": 10,
//     "herbal_tea": 2
// }
  void post_card() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('دمنوش به سبد خرید اضافه شد')));
  }

  void already_card() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 160, 0, 0),
        content: Text('این دمنوش قبلا به سبد خرید اضافه شده')));
  }

  void add_to_card() async {
    String url = Helper.url + "card/post_herbalTea_card";
    var body = json
        .encode({"user": UserStaticFile.user_id!, "herbaltea": herbaltea_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      post_card();
    } else if ((res.statusCode == 208)) {
      already_card();
    } else {
      error_create_favorite();
    }
  }

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

  void delete_herbaltea_faviorate() async {
    String url = Helper.url + 'history/delete_faviorate_herbaltea_user';
    var body = json
        .encode({"user": UserStaticFile.user_id!, "herbaltea": herbaltea_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      delete_favorite();
    } else {
      error_delete_favorite();
    }
  }

  void delete_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('با موفقیت از لیست حذف شد')));
  }

  void error_delete_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('متاسفانه از لیست حذف نشد')));
  }
}