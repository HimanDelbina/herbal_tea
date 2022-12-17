import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sara_plant/components/shared_helper.dart';

import '../../components/helper.dart';
import '../../components/user_static.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: [
              items(first_name, "first_name", "first_name", IconlyLight.profile,
                  false, TextInputType.name),
              items(last_name, "last_name", "last_name", IconlyLight.profile,
                  false, TextInputType.name),
              items(phone_number, "phone_number", "phone_number",
                  IconlyLight.call, false, TextInputType.phone),
              items(address, "address", "address", IconlyLight.location, false,
                  TextInputType.streetAddress),
              items(password, "password", "password", IconlyLight.password,
                  false, TextInputType.phone),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  create_user();
                },
                child: Container(
                  height: myHeight * 0.07,
                  width: myWidth,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Center(
                    child: Text("ثبت نام"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget items(TextEditingController controller, String hint, String lable,
      IconData icon, bool pass, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
          controller: controller,
          obscureText: pass,
          keyboardType: type,
          onChanged: (String value) {
            setState(() {
              value = controller.text;
            });
          },
          decoration: InputDecoration(
              hintText: hint,
              suffixIcon: Icon(icon),
              labelText: lable,
              border: const OutlineInputBorder())),
    );
  }

  void message_create_user() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1), content: Text('user create')));
  }

  void message_error_create_user() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1), content: Text('user not create')));
  }

  void message_already_create_user() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1), content: Text('user already')));
  }

  void create_user() async {
    String url = Helper.url + "person/create_user";
    var body = json.encode({
      "first_name": first_name.text,
      "last_name": last_name.text,
      "phone": phone_number.text,
      "password": password.text,
      "address": address.text,
      "image": "",
      "role": 1,
    });
    var res = await Helper.postApi(url, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> result = json.decode(res.body);
      SharedHelper.shared_set_token(result['token']);
      UserStaticFile.user_id = result["payload"]["id"];
      UserStaticFile.first_name =
          utf8.decode(result["payload"]["first_name"].codeUnits);
      UserStaticFile.last_name =
          utf8.decode(result["payload"]["last_name"].codeUnits);
      UserStaticFile.phone_number =
          utf8.decode(result["payload"]["phone"].codeUnits);
      UserStaticFile.address =
          utf8.decode(result["payload"]["address"].codeUnits);
      message_create_user();
    } else if (res.statusCode == 208) {
      message_already_create_user();
    } else {
      message_error_create_user();
    }
  }
}
