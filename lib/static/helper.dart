import 'package:http/http.dart' as http;
import 'package:sara_plant/static/shared_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  // static String url = "http://swaaaa.ir:7777/";
  // static String imageUrl = "http://swaaaa.ir:7777";
  static String url = "http://192.168.1.100:7777/";
  static String imageUrl = "http://192.168.1.100:7777";

  static Future<dynamic> getApi(String urll) async {
    Uri uri = Uri.parse(urll);
    var res =
        await http.get(uri, headers: {"Content-type": "application/json"});
    return res;
  }

  static Future<dynamic> getApiToken(String urll) async {
    Uri uri = Uri.parse(urll);
    String token = await getToken();

    var res = await http.get(uri, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer " + token
    });

    return res;
  }

  static Future<dynamic> postApi(String urll, var body) async {
    Uri uri = Uri.parse(urll);
    var res = await http.post(uri,
        headers: {"Content-type": "application/json"}, body: body);
    return res;
  }

  static Future<dynamic> postApiToken(String urll, var body) async {
    Uri uri = Uri.parse(urll);
    String token = await getToken();
    // SharedHelper.shared_get_token();

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Token " + SharedHelper.my_token.toString()
    };
    var res = await http.post(uri, headers: headers, body: body);
    return res;
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // SharedHelper.shared_get_token();
    String token = pref.getString("token") ?? "";

    print(token);
    return token;
  }
}


// 5859 8310 1674 6421