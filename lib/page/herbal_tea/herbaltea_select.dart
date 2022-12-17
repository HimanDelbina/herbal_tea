import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/page/herbal_tea/herbaltea_data.dart';
import 'package:sara_plant/page/herbal_tea/herbaltea_khavas.dart';
import '../../components/helper.dart';
import '../../model/new/herbaltea_select_model.dart';
import '../../provider/theme.dart';
import 'herbaltea_zarar.dart';

class HerbalTeaSelect extends StatefulWidget {
  int? id;
  HerbalTeaSelect({super.key, this.id});

  @override
  State<HerbalTeaSelect> createState() => _HerbalTeaSelectState();
}

class _HerbalTeaSelectState extends State<HerbalTeaSelect> {
  @override
  void initState() {
    super.initState();
    get_all_data_herbaltea(widget.id!);
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
                  tab_item("دمنوش"),
                  tab_item("خواص"),
                  tab_item("ضرر"),
                ],
              )
            ],
          ),
        ),
        body: is_loading
            ? TabBarView(
                children: [
                  HerbalTeaData(
                      data: herbaltea_data,
                      image: image_data_final,
                      description: herbaltea_data[0].description),
                  HerbalTeaKhavas(data: khavas_data_final),
                  HerbalTeaZarar(data: zarar_data_final)
                ],
              )
            : const My_loading(),
      ),
    );
  }

  Widget tab_item(String title) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0), child: Text(title));
  }

  var herbaltea_data = [];
  var zarar_data = [];
  var zarar_data_final = [];
  var khavas_data = [];
  var khavas_data_final = [];
  var image_data = [];
  var image_data_final = [];
  var herbaltea_data_backup = [];
  List herbaltea_data_list = [];
  bool is_loading = false;
  Future<HerbalTeaSelectModel?> get_all_data_herbaltea(int id) async {
    String url = Helper.url + 'herbaltea/get_herbaltea_by_id/' + id.toString();
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      var x = res.body;
      var get_data = herbalTeaSelectModelFromJson(x);
      setState(() {
        herbaltea_data = get_data;
        herbaltea_data_backup = get_data;
        herbaltea_data_list = get_data;
        zarar_data = herbaltea_data[0].zararHerbaltea;
        khavas_data = herbaltea_data[0].khavasHerbaltea;
        image_data = herbaltea_data[0].imageHerbaltea;
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
      for (var i = 0; i < image_data.length; i++) {
        setState(() {
          image_data_final.add(image_data[i]);
        });
      }
      print(zarar_data_final);
    } else {
      print('Roles List NOK');
    }
  }
}
