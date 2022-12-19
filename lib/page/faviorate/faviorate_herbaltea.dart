import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/custom_transition.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/error_page.dart';
import 'package:sara_plant/components/sign_up_error.dart';
import 'package:sara_plant/static/message_static.dart';
import 'package:sara_plant/static/user_static.dart';

import '../../model/faviorate_herbattea_model.dart';
import '../../provider/theme.dart';
import '../../static/helper.dart';

class FaviorateHerbalTea extends StatefulWidget {
  const FaviorateHerbalTea({super.key});

  @override
  State<FaviorateHerbalTea> createState() => _FaviorateHerbalTeaState();
}

class _FaviorateHerbalTeaState extends State<FaviorateHerbalTea> {
  int time_for_show_data = 0;
  @override
  void initState() {
    super.initState();
    if (UserStaticFile.user_id != null) {
      get_faviorate_herbaltea(UserStaticFile.user_id!);
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
                    child: item(faviorate_data),
                  )
        : const SignUpError();
  }

  Widget item(var data) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data[index].herbaltea.name,
                    style: TextStyle(color: theme.text)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        id_data_for_delete = data[index].id;
                      });
                      delete_faviorate_herbaltea(id_data_for_delete!);
                    },
                    child: Icon(IconlyLight.delete, color: theme.deleteIcon))
              ],
            ),
          ),
        );
      },
    );
  }

  var faviorate_data = [];
  var faviorate_data_backup = [];
  List faviorate_data_list = [];
  Future<HerbalTeaFaviorateModel?> get_faviorate_herbaltea(int id_data) async {
    String url = Helper.url +
        'history/get_faviorate_herbaltea_by_id/' +
        id_data.toString();
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      var x = res.body;
      var get_data = herbalTeaFaviorateModelFromJson(x);
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

  int? id_data_for_delete;

  Future<HerbalTeaFaviorateModel?> delete_faviorate_herbaltea(
      int id_data) async {
    String url = Helper.url +
        'history/delete_faviorate_herbaltea_by_id/' +
        id_data.toString();
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      MyMessage.mySnackbarMessage(context, 'با موفقیت از لیست حذف شد', 1);

      get_faviorate_herbaltea(UserStaticFile.user_id!);
    } else {
      MyMessage.mySnackbarMessage(context, 'متاسفانه از لیست حذف نشد', 1);
    }
  }
}
