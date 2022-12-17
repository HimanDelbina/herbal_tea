import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sara_plant/components/shared_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/helper.dart';
import '../model/new/plant_first_model.dart';

class PlantGet extends ChangeNotifier {
  List<PlantFirstModel> _map = [];
  List<PlantFirstModel> get map => _map;
  bool _error = false;
  bool _is_signin = false;
  bool _refresh = false;
  String _errorMessage = "";
  String _token = "";
  bool get error => _error;
  bool get is_signin => _is_signin;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;
  String get token => _token;

  Future<List<PlantFirstModel>?> get fetchData async {
    SharedHelper.shared_get_token();
    _refresh = true;
    var response;
    if (SharedHelper.my_token != null) {
      response = await http
          .get(Uri.parse(Helper.url + "plant/get_plant_by_token"), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token " + SharedHelper.my_token!
      });
    } else {
      response = await http
          .get(Uri.parse(Helper.url + "plant/get_plant_by_token"), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });
    }
    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = plantFirstModelFromJson(x);
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
