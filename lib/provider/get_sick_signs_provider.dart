// // import 'package:flutter/material.dart';
// // import 'package:sara_plant/model/sick_signs_model.dart';

// // import 'get_data/get_sick_by_data.dart';

// // class SickSignsGet_byIDProvider extends ChangeNotifier {
// //   final _service = SickSignIDService();
// //   bool isLoading = false;
// //   List<SickSignsModel> _map = [];
// //   List<SickSignsModel> get map => _map;

// //   Future<void> get_signs() async {
// //     isLoading = true;
// //     notifyListeners();

// //     final responce = await _service.getsicksigns_by_id();

// //     _map = responce!;
// //     isLoading = false;
// //     notifyListeners();
// //   }

// //   void initialValues() {
// //     _map = [];
// //     notifyListeners();
// //   }
// // }

// import 'package:flutter/material.dart';

// import '../model/sick_signs_model.dart';
// import 'get_data/get_sick_by_data.dart';

// class Data extends ChangeNotifier{

// late SickSignsModel dataModel;

// fetchData(context) async{

//   dataModel = await getData(context);

//   notifyListeners();
// }

// }
// // import 'package:flutter/material.dart';
// // import 'package:sara_plant/model/sick_signs_model.dart';
// // import 'package:sara_plant/provider/get_data/get_sick_by_data.dart';

// // class SickSignsProvider extends ChangeNotifier {
// //   final _service = SickSignService();
// //   bool isLoading = false;
// //   List<SickSignsModel> _todos = [];
// //   List<SickSignsModel> get todos => _todos;

// //   Future<void> getAllTodos() async {
// //     isLoading = true;
// //     notifyListeners();

// //     final response = await _service.getAll();

// //     _todos = response;
// //     isLoading = false;
// //     notifyListeners();
// //   }
// // }
