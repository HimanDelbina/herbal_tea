
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/plant_toturial_model.dart';
import '../static/helper.dart';

class PlantToturiaGet extends ChangeNotifier {
  List<PlantToturialModel> _map = [];
  bool _error = false;
  bool _refresh = false;
  String _errorMessage = "";
  List<PlantToturialModel> get map => _map;
  bool get error => _error;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  Future<List<PlantToturialModel>?> get fetchData async {
    _refresh = true;
    var response = await http
        .get(Uri.parse(Helper.url + "tutorial/get_tutorial"), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = plantToturialModelFromJson(x);
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
