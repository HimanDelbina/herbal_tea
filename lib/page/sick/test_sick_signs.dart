// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sara_plant/model/sick_signs_model.dart';
// import '../../provider/get_sick_signs_provider.dart';

// class TestGetSick extends StatefulWidget {
//   int? id;
//   TestGetSick({super.key, this.id});

//   @override
//   State<TestGetSick> createState() => _TestGetSickState();
// }

// class _TestGetSickState extends State<TestGetSick> {
//   @override
//   void initState() {
//     super.initState();
//     final data = Provider.of<Data>(context, listen: false);
//     data.fetchData(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<Data>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Provider Network Call"),
//       ),
//       body: Center(child: Container(child: Text(data.dataModel.name))),
//     );
//   }

//   Future<SickSignsModel> getData(context) async {
//     late SickSignsModel dataModel;

//     try {
//       final response = await http
//           .get(Uri.parse('http://swaaaa.ir:7777/sick/get_signs_by_sick_id/1'));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         dataModel = SickSignsModel.fromJson(data);
//       } else {
//         print("Something went wrong");
//       }
//     } catch (e) {
//       print(e.toString());
//     }

//     return dataModel;
//   }
// }
