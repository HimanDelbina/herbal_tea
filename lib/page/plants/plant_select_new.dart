import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/my_opacity_animation.dart';
import 'package:sara_plant/page/plants/plant_khavas.dart';
import 'package:sara_plant/page/plants/plant_select.dart';
import 'package:sara_plant/page/plants/plant_zarar.dart';
import '../../model/new/plant_select_model.dart';
import '../../provider/theme.dart';
import '../../static/helper.dart';
import 'package:easy_localization/easy_localization.dart';

class PlantSelectNew extends StatefulWidget {
  int? id;
  PlantSelectNew({super.key, this.id});

  @override
  State<PlantSelectNew> createState() => _PlantSelectNewState();
}

class _PlantSelectNewState extends State<PlantSelectNew> {
  @override
  void initState() {
    super.initState();
    get_all_dat_plant(widget.id!);
  }

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
                  tab_item("plants".tr(), 1000),
                  tab_item("properties".tr(), 1500),
                  tab_item("loss".tr(), 2000),
                ],
              )
            ],
          ),
        ),
        body: is_loading
            ? TabBarView(
                children: [
                  PlantSelect(
                      data: plant_data,
                      image: Helper.imageUrl + plant_data[0].image,
                      description: plant_data[0].description),
                  PlantKhavas(data: khavas_data_final),
                  PlantZarar(data: zarar_data_final)
                ],
              )
            : const My_loading(),
      ),
    );
  }

  Widget tab_item(String title, int duration) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: MyOpacityAnimation(duration: duration, child: Text(title)));
  }

  var plant_data = [];
  var zarar_data = [];
  var zarar_data_final = [];
  var khavas_data = [];
  var khavas_data_final = [];
  var plant_data_backup = [];
  List plant_data_list = [];
  bool is_loading = false;
  Future<PlantSelectModel?> get_all_dat_plant(int id) async {
    String url = Helper.url + 'plant/get_plant_by_id/' + id.toString();
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      var x = res.body;
      var get_data = plantSelectModelFromJson(x);
      setState(() {
        plant_data = get_data;
        plant_data_backup = get_data;
        plant_data_list = get_data;
        zarar_data = plant_data[0].zararPlant;
        khavas_data = plant_data[0].khavasPlant;
        is_loading = true;
      });
      for (var i = 0; i < zarar_data.length; i++) {
        setState(() {
          zarar_data_final.add(zarar_data[i]);
        });
      }
      for (var i = 0; i < khavas_data.length; i++) {
        setState(() {
          khavas_data_final.add(khavas_data[i]);
        });
      }
      print(zarar_data_final);
    } else {
      print('Roles List NOK');
    }
  }
}
