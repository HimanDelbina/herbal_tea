import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/model/new/plant_select_model.dart';
import 'package:sara_plant/page/plants/plant_khavas.dart';
import 'package:sara_plant/page/plants/plant_zarar.dart';
import '../../components/error_get_data.dart';
import '../../components/helper.dart';
import '../../provider/theme.dart';

class PlantSelect extends StatefulWidget {
  List? data;
  String? image;
  String? description;
  PlantSelect({Key? key, this.data, this.image, this.description})
      : super(key: key);

  @override
  State<PlantSelect> createState() => _PlantSelectState();
}

class _PlantSelectState extends State<PlantSelect> {
  @override
  void initState() {
    super.initState();
    // get_all_dat_plant(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      // appBar: AppBar(
      //     iconTheme: IconThemeData(color: theme.iconItem),
      //     backgroundColor: Colors.transparent,
      //     leadingWidth: myWidth * 0.3,
      //     leading: Center(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 5.0),
      //         child: Text(
      //             plant_data.length == 0 ? "" : plant_data[0].mazaj.name,
      //             style: const TextStyle(
      //                 color: Colors.redAccent, fontWeight: FontWeight.bold)),
      //       ),
      //     ),
      //     centerTitle: true,
      //     title: Text(plant_data.length == 0 ? "" : plant_data[0].name),
      //     titleTextStyle: const TextStyle(
      //         color: Colors.black,
      //         fontFamily: "Vazir",
      //         fontWeight: FontWeight.bold,
      //         fontSize: 18.0),
      //     actions: [
      //       GestureDetector(
      //           onTap: (() {
      //             Navigator.pop(context);
      //           }),
      //           child: const Padding(
      //               padding: EdgeInsets.symmetric(horizontal: 15.0),
      //               child: Icon(IconlyLight.arrow_left_2))),
      //     ],
      //     elevation: 0.0),
      body: widget.data!.length == 0
          ? const ErrorGetData()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Image.network(widget.image!),
                        Text(widget.description!, textAlign: TextAlign.justify),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget khavas_zarar_show(String title, String data, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color))
          ],
        ),
        Text(data == "" ? "" : data, textAlign: TextAlign.justify),
      ],
    );
  }

  Widget button_khavas_zara_show(String title, Color color, Widget widget) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Container(
        height: myHeight * 0.06,
        width: myWidth * 0.4,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }

  // var plant_data = [];
  // var zarar_data = [];
  // var zarar_data_final = [];
  // var khavas_data = [];
  // var khavas_data_final = [];
  // var plant_data_backup = [];
  // List plant_data_list = [];
  // Future<PlantSelectModel?> get_all_dat_plant(int id) async {
  //   String url = Helper.url + 'plant/get_plant_by_id/' + id.toString();
  //   var res = await Helper.getApi(url);
  //   if (res.statusCode == 200) {
  //     var x = res.body;
  //     var get_data = plantSelectModelFromJson(x);
  //     setState(() {
  //       plant_data = get_data;
  //       plant_data_backup = get_data;
  //       plant_data_list = get_data;
  //       zarar_data = plant_data[0].zararPlant;
  //       khavas_data = plant_data[0].khavasPlant;
  //     });
  //     for (var i = 0; i < zarar_data.length; i++) {
  //       setState(() {
  //         zarar_data_final.add(zarar_data[i]);
  //       });
  //     }
  //     for (var i = 0; i < khavas_data.length; i++) {
  //       setState(() {
  //         khavas_data_final.add(khavas_data[i]);
  //       });
  //     }
  //     print(zarar_data_final);
  //   } else {
  //     print('Roles List NOK');
  //   }
  // }

  // Widget show_zarar_plant(List data) {
  //   double myHeight = MediaQuery.of(context).size.height;
  //   double myWidth = MediaQuery.of(context).size.width;
  //   ThemeBloc theme = Provider.of<ThemeBloc>(context);
  //   return Column(
  //     children: [
  //       Row(
  //         children: const [
  //           Text("ضرر",
  //               style: TextStyle(
  //                   fontWeight: FontWeight.bold, color: Colors.redAccent)),
  //         ],
  //       ),
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: data.length,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 5.0),
  //               child: Container(
  //                 height: myHeight * 0.07,
  //                 width: myWidth,
  //                 decoration: BoxDecoration(
  //                     color: Colors.redAccent.withOpacity(0.1),
  //                     borderRadius: BorderRadius.circular(5.0)),
  //                 child: Row(
  //                   children: [Text(data[index].name)],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget show_khavas_plant(List data) {
  //   double myHeight = MediaQuery.of(context).size.height;
  //   double myWidth = MediaQuery.of(context).size.width;
  //   ThemeBloc theme = Provider.of<ThemeBloc>(context);
  //   return ListView.builder(
  //     itemCount: data.length,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 5.0),
  //         child: Container(
  //           height: myHeight * 0.07,
  //           width: myWidth,
  //           decoration: BoxDecoration(
  //               color: Colors.greenAccent.withOpacity(0.1),
  //               borderRadius: BorderRadius.circular(5.0)),
  //           child: Row(
  //             children: [Text(data[index].name)],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
