import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sara_plant/components/helper.dart';
import 'package:sara_plant/components/shared_helper.dart';
import 'package:sara_plant/model/new/card_model.dart';
import '../model/new/herbaltea_model.dart';

class CardGet extends ChangeNotifier {
  List<CardModel> _map = [];
  bool _error = false;
  bool _is_signin = false;
  bool _refresh = false;
  String _errorMessage = "";
  String _token = "";
  int _show_data = 0;
  List<CardModel> get map => _map;
  bool get error => _error;
  bool get is_signin => _is_signin;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;
  String get token => _token;
  int get show_data => _show_data;

  Future<List<CardModel>?> get fetchData async {
    SharedHelper.shared_get_token();
    _refresh = true;

    var response;

    response = await http
        .get(Uri.parse(Helper.url + "card/get_card_by_token"), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token " + SharedHelper.my_token!
    });

    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = cardModelFromJson(x);
        _show_data = 200;
        _error = false;
      } catch (e) {
        _show_data = 400;
        _error = true;
        _errorMessage = e.toString();
        _map = [];
      }
    } else {
      _show_data = 404;
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
