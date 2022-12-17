import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/icon_clicked.dart';
import 'package:sara_plant/page/sick/sick_select.dart';
import 'package:sara_plant/provider/get_sick.dart';
import '../../components/error_get_data.dart';
import '../../components/helper.dart';
import '../../components/search_component.dart';
import '../../components/shared_helper.dart';
import '../../components/user_static.dart';
import '../../provider/theme.dart';
import '../register/signup.dart';

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

  showFinalItem(int index) {
    if (index == 0) {
      return listViewShow();
    } else if (index == 1) {
      return gridViewShow();
    }
  }

  Widget gridViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Consumer<SickGet>(builder: (context, value, child) {
        return value.map.length == 0 && !value.error
            ? const ErrorGetData()
            : value.error
                ? Text(value.errorMessage.toString())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemCount: value.map.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: myHeight * 0.04,
                                  width: myWidth * 0.08,
                                  // color: Colors.grey.withOpacity(0.1),
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
                                              : show_data[index].isLike == true
                                                  ? delete_sick_faviorate()
                                                  : signup_erro_message();
                                        },
                                        child: Icon(
                                            show_data[index].isLike == true
                                                ? IconlyBold.bookmark
                                                : IconlyLight.bookmark)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
      }),
    );
  }

  var show_data = [];
  var show_data_Search = [];

  Widget listViewShow() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Consumer<SickGet>(builder: (context, value, child) {
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
                                    builder: (context) =>
                                        SickSelect(id: show_data[index].id)));
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                show_data[index].isLike == false
                                            ? save_sick()
                                            : show_data[index].isLike == true
                                                ? delete_sick_faviorate()
                                                : signup_erro_message();
                                      },
                                      child: MyFaviorateIcon(
                                          is_fave:
                                              show_data[index].isLike == true),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  },
                );
    });
  }

  Widget iconItemShow(double height, double width, String image, Color color,
      VoidCallback ontap) {
    return GestureDetector(
        onTap: ontap,
        child: Image.asset(image, height: height, width: width, color: color));
  }

  void create_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('بیماری به لیست مورد علاقه ها اضافه شد')));
  }

  void already_create_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 160, 0, 0),
        content: Text('این بیماری قبلا به لیست مورد علاقه ها اضافه شده')));
  }

  void error_create_favorite() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 160, 0, 0),
        content: Text('در حال حاضر خطایی رخ داده لطفا بعدا امتحان کنید')));
  }

  int? sick_id;
  void save_sick() async {
    String url = Helper.url + "history/post_faviorate_sick";
    var body = json.encode({"user": UserStaticFile.user_id!, "sick": sick_id});
    var res = await Helper.postApi(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      create_favorite();
    } else if ((res.statusCode == 208)) {
      already_create_favorite();
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

  void delete_sick_faviorate() async {
    String url = Helper.url + 'history/delete_faviorate_sick_user';
    var body = json.encode({"user": UserStaticFile.user_id!, "sick": sick_id});
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
