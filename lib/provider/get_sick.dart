import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/new/sick_model.dart';
import '../model/new/sick_select_model.dart';
import '../static/helper.dart';
import '../static/shared_helper.dart';

class SickGet extends ChangeNotifier {
  List<SickSelectModel> _map = [];
  bool _error = false;
  bool _refresh = false;
  String _errorMessage = "";
  List<SickSelectModel> get map => _map;
  bool get error => _error;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  Future<List<SickModel>?> get fetchData async {
    SharedHelper.shared_get_token();
    _refresh = true;
    var response;
    if (SharedHelper.my_token != null) {
      response = await http
          .get(Uri.parse(Helper.url + "sick/get_sick_by_token"), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token " + SharedHelper.my_token!
      });
    } else {
      response = await http
          .get(Uri.parse(Helper.url + "sick/get_sick_by_token"), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });
    }
    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = sickSelectModelFromJson(x);
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
