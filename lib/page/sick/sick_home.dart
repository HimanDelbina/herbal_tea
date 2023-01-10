import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/icon_clicked.dart';
import 'package:sara_plant/page/sick/sick_select.dart';
import 'package:sara_plant/provider/get_sick.dart';
import 'package:sara_plant/static/message_static.dart';
import '../../components/error_get_data.dart';
import '../../components/error_page.dart';
import '../../components/search_component.dart';
import '../../static/helper.dart';
import '../../static/shared_helper.dart';
import '../../static/user_static.dart';
import '../../provider/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class SickHome extends StatefulWidget {
  const SickHome({super.key});

  @override
  State<SickHome> createState() => _SickHomeState();
}

class _SickHomeState extends State<SickHome> {
  int indexItem = 0;
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

  TextEditingController sick_search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    context.read<SickGet>().fetchData;
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
                controller: sick_search_controller,
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
                    show_data =
                        SearchComponent.search(show_data_Search, value, "sick");
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

  var show_data = [];
  var show_data_Search = [];

  Widget listViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Consumer<SickGet>(builder: (context, value, child) {
      sick_search_controller.text == ""
          ? show_data = value.map
          : show_data = show_data;
      show_data_Search = value.map;
      return value.map.length == 0 && !value.error
          ? const My_loading()
          : value.error
              ? Text(value.errorMessage.toString())
              : show_data.length != 0
                  ? ListView.builder(
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
                                        builder: (context) => SickSelect(
                                            data: show_data[index])));
                              },
                              child: AnimatedContainer(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                                curve: Curves.easeInOut,
                                duration:
                                    Duration(milliseconds: 300 + (index * 200)),
                                transform: Matrix4.translationValues(
                                    startAnimation ? 0 : myWidth, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(show_data[index].name,
                                        style: TextStyle(
                                            color: theme.text,
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      height: myHeight * 0.04,
                                      width: myWidth * 0.08,
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              sick_id = show_data[index].id;
                                            });
                                            SharedHelper.my_token != null &&
                                                    show_data[index].isLike ==
                                                        false
                                                ? save_sick()
                                                : show_data[index].isLike ==
                                                        true
                                                    ? delete_sick_faviorate()
                                                    : MyMessage.mySignUpMessage(
                                                        context,
                                                        "complete_signUp".tr(),
                                                        1);
                                          },
                                          child: MyFaviorateIcon(
                                              is_fave:
                                                  show_data[index].isLike ==
                                                      true),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        );
                      },
                    )
                  : ErrorPage(
                      image: "assets/animation/empty.json",
                      text: "null_search".tr(),
                      is_rich: false);
    });
  }

  Widget iconItemShow(double height, double width, String image, Color color,
      VoidCallback ontap) {
    return GestureDetector(
        onTap: ontap,
        child: Image.asset(image, height: height, width: width, color: color));
  }

  int? sick_id;
  void save_sick() async {
    String url = Helper.url + "history/post_faviorate_sick";
    var body = json.encode({"user": UserStaticFile.user_id!, "sick": sick_id});
    var res = await Helper.postApi(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessage(
          context, "add_sick_faviorate_complete".tr(), 1);
    } else if ((res.statusCode == 208)) {
      MyMessage.mySnackbarMessage(
          context, "add_sick_faviorate_already".tr(), 1);
    } else {
      MyMessage.mySnackbarMessage(context, "add_error".tr(), 1);
    }
  }

  void delete_sick_faviorate() async {
    String url = Helper.url + 'history/delete_faviorate_sick_user';
    var body = json.encode({"user": UserStaticFile.user_id!, "sick": sick_id});
    var res = await Helper.postApiToken(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      MyMessage.mySnackbarMessage(context, "delete_complete".tr(), 1);
    } else {
      MyMessage.mySnackbarMessage(context, "delete_error".tr(), 1);
    }
  }
}
