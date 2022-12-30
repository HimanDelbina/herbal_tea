import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/new/all_mazaj_model.dart';
import '../model/new/plant_first_model.dart';
import '../static/helper.dart';
import '../static/shared_helper.dart';

class AllMazajGet extends ChangeNotifier {
  List<AllMajazModel> _map = [];
  List<AllMajazModel> get map => _map;
  bool _error = false;
  bool _is_signin = false;
  bool _refresh = false;
  String _errorMessage = "";
  bool get error => _error;
  bool get is_signin => _is_signin;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  Future<List<PlantFirstModel>?> get fetchData async {
    _refresh = true;
    var response;

    response = await http
        .get(Uri.parse(Helper.url + "mazaj/get_mazaj_by_id"), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = allMajazModelFromJson(x);
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = [];
      }
    } else {
      _error = false;
      _errorMessage = "Error : Conection Error";
      _map = [];
    }
    notifyListeners();
  }

  void initialValues() {
    _map = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
