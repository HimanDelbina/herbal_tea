import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/error_page.dart';
import 'package:sara_plant/components/sign_up_error.dart';

import '../../components/helper.dart';
import '../../components/user_static.dart';
import '../../model/faviorate_plant_model.dart';
import '../../provider/theme.dart';
import '../plants/plant_select_new.dart';

class FavioratePlant extends StatefulWidget {
  const FavioratePlant({super.key});

  @override
  State<FavioratePlant> createState() => _FavioratePlantState();
}

class _FavioratePlantState extends State<FavioratePlant> {
  int time_for_show_data = 0;
  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
    if (UserStaticFile.user_id != null) {
      get_faviorate_plant(UserStaticFile.user_id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return UserStaticFile.user_id != null
        ? time_for_show_data == 1
            ? ErrorPage(
                image: "assets/animation/empty.json",
                text: "لیست مورد علاقه شما خالی است",
                is_rich: false)
            : faviorate_data.length == 0
                ? const My_loading()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: item(faviorate_data))
        : const SignUpError();
  }

  Widget item(var data) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 300 + (index * 200)),
            transform:
                Matrix4.translationValues(startAnimation ? 0 : myWidth, 0, 0),
            child: ListTile(
                contentPadding: const EdgeInsets.all(4.0),
                dense: true,
                enableFeedback: true,
                horizontalTitleGap: 15.0,
                iconColor: theme.deleteIcon,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlantSelectNew(id: data[index].plant.id)));
                },
                tileColor: Colors.greenAccent.withOpacity(0.05),
                title: Text(data[index].plant.name,
                    style: TextStyle(
                        color: theme.text, fontWeight: FontWeight.bold)),
                leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        Helper.imageUrl + data[index].plant.image)),
                trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        id_data_for_delete = data[index].id;
                      });
                      delete_faviorate_plant(id_data_for_delete!);
                    },
                    child: const Icon(IconlyBold.delete))),
          ),
        );
      },
    );
  }

  var faviorate_data = [];
  var faviorate_data_backup = [];
  List faviorate_data_list = [];
  Future<FavioratePlantModel?> get_faviorate_plant(int id_data) async {
    String url =
        Helper.url + 'history/get_faviorate_plant_by_id/' + id_data.toString();
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      var x = res.body;
      var get_data = favioratePlantModelFromJson(x);
      if (get_data.length == 0) {
        setState(() {
          time_for_show_data = 1;
        });
      }
      setState(() {
        faviorate_data = get_data;
        faviorate_data_backup = get_data;
        faviorate_data_list = get_data;
      });
    } else {
      print('Roles List NOK');
    }
  }

  void long_press() {
    Tooltip(
      message: 'Text',
      child: const Text("دارو گیاهی"),
    );
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

  int? id_data_for_delete;

  Future<FavioratePlantModel?> delete_faviorate_plant(int id_data) async {
    String url = Helper.url +
        'history/delete_faviorate_plant_by_id/' +
        id_data.toString();
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      delete_favorite();
      get_faviorate_plant(UserStaticFile.user_id!);
    } else {
      error_delete_favorite();
    }
  }
}
