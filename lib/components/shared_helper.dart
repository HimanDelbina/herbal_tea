import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sara_plant/components/user_static.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class SharedHelper {
  static String? my_token;
  static bool? my_theme = false;
  static shared_set_token(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
    shared_get_token();
  }

  static Future shared_get_token() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    my_token = pref.getString("token");
    return my_token;
  }

  static shared_cheack_token() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    my_token = pref.getString("token");
    token_get();
  }

  static shared_set_theme(bool theme) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("theme", theme);
    SharedHelper.shared_get_theme();
  }

  static shared_get_theme() async {
    bool? test = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    test = pref.getBool("theme");
    my_theme = test;
  }

  static token_get() {
    SharedHelper.shared_get_token();
    if (SharedHelper.my_token != null) {
      check_token();
    }
  }

  static check_token() async {
    shared_get_token();
    String url = Helper.url + "person/check_token/";
    var data = json.encode({});
    final res = await http.post(Uri.parse(url), body: data, headers: {
      "Content-Type": "application/json",
      "Authorization": "Token " + my_token!
    });
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> result = json.decode(res.body);
      UserStaticFile.user_id = result["id"];
      UserStaticFile.first_name = utf8.decode(result["first_name"].codeUnits);
      UserStaticFile.last_name = utf8.decode(result["last_name"].codeUnits);
      UserStaticFile.phone_number = utf8.decode(result["phone"].codeUnits);
      UserStaticFile.address = utf8.decode(result["address"].codeUnits);
    } else {}
  }
}
