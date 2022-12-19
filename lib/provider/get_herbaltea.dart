import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/new/herbaltea_model.dart';
import '../static/helper.dart';
import '../static/shared_helper.dart';

class HerbalTeaGet extends ChangeNotifier {
  List<HerbalTeaModel> _map = [];
  bool _error = false;
  bool _is_signin = false;
  bool _refresh = false;
  String _errorMessage = "";
  String _token = "";
  List<HerbalTeaModel> get map => _map;
  bool get error => _error;
  bool get is_signin => _is_signin;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;
  String get token => _token;

  Future<List<HerbalTeaModel>?> get fetchData async {
    SharedHelper.shared_get_token();
    _refresh = true;

    var response;
    if (SharedHelper.my_token != null) {
      response = await http.get(
          Uri.parse(Helper.url + "herbaltea/get_herbaltea_by_token"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Token " + SharedHelper.my_token!
          });
    } else {
      response = await http.get(
          Uri.parse(Helper.url + "herbaltea/get_herbaltea_by_token"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          });
    }
    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = herbalTeaModelFromJson(x);
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
