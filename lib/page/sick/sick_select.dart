import 'package:flutter/material.dart';
import 'package:sara_plant/components/error_get_data.dart';
import '../../model/new/sick_select_model.dart';
import '../../static/helper.dart';

class SickSelect extends StatefulWidget {
  int? id;
  SickSelect({super.key, this.id});

  @override
  State<SickSelect> createState() => _SickSelectState();
}

class _SickSelectState extends State<SickSelect> {
  @override
  void initState() {
    super.initState();
    get_signs(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: is_loading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView.builder(
                  itemCount: signs_data_final.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Text(signs_data_final[index].name);
                  },
                ),
              )
            : const My_loading(),
      ),
    );
  }

  var sick_data = [];
  var sick_data_backup = [];
  var signs_data = [];
  var signs_data_final = [];
  List sick_data_list = [];
  bool is_loading = false;
  Future<SickSelectModel?> get_signs(int id_data) async {
    String url = Helper.url + 'sick/get_sick_by_id/' + id_data.toString();
    var res = await Helper.getApi(url);
    if (res.statusCode == 200) {
      var x = res.body;
      var get_data = sickSelectModelFromJson(x);
      setState(() {
        sick_data = get_data;
        sick_data_backup = get_data;
        sick_data_list = get_data;
        signs_data = sick_data[0].signsSick;
        is_loading = true;
      });
      for (var i = 0; i < signs_data.length; i++) {
        setState(() {
          signs_data_final.add(signs_data[i]);
        });
      }
    } else {
      print('Roles List NOK');
    }
  }
}
