// // import 'dart:convert';
// // import 'dart:developer';
// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'package:sara_plant/components/helper.dart';
// // import '../../model/sick_signs_model.dart';

// // class SickSignIDService {
// //   Future<List<SickSignsModel>?> getsicksigns_by_id() async {
// //     var result;
// //     try {
// //       final response =
// //           await http.get(Uri.parse(Helper.url + "sick/get_signs_by_sick_id/1"));
// //       if (response.statusCode == 200) {
// //         final item = json.decode(response.body);
// //         result = sickSignsModelFromJson(item);
// //       } else {
// //         print("error");
// //       }
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //     return [];
// //   }
// // }

// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:sara_plant/model/sick_signs_model.dart';

// // class SickSignService {
// //   Future<List<SickSignsModel>> getAll() async {
// //     const url = "http://swaaaa.ir:7777/sick/get_signs_by_sick_id/1";
// //     final uri = Uri.parse(url);
// //     final response = await http.get(uri);
// //     if (response.statusCode == 200) {
// //       final json = jsonDecode(response.body) as List;
// //       final todos = json.map((e) {
// //         return SickSignsModel(
// //           id: e['id'],
// //           name: e['name'],
// //           sick: e['sick'],
// //         );
// //       }).toList();
// //       return todos;
// //     }
// //     return [];
// //   }
// // }

// import 'dart:convert';

// import '../../model/sick_signs_model.dart';
// import 'package:http/http.dart' as http;

// Future<SickSignsModel> getData(context) async {
//   late SickSignsModel dataModel;

//   try {
//     final response = await http
//         .get(Uri.parse('http://swaaaa.ir:7777/sick/get_signs_by_sick_id/1'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       dataModel = SickSignsModel.fromJson(data);
//     } else {
//       print("Something went wrong");
//     }
//   } catch (e) {
//     print(e.toString());
//   }

//   return dataModel;
// }
