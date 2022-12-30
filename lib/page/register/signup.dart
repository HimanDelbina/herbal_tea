import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/start_page.dart';
import 'package:sara_plant/static/message_static.dart';
import 'package:sara_plant/static/shared_helper.dart';
import '../../components/error_get_data.dart';
import '../../provider/theme.dart';
import '../../static/helper.dart';
import '../../static/user_static.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool show_button = true;

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
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: [
              items(first_name, "نام", "نام", IconlyLight.profile, false,
                  TextInputType.name),
              items(last_name, "نام خانوادگی", "نام خانوادگی",
                  IconlyLight.profile, false, TextInputType.name),
              items(phone_number, "شماره موبایل", "شماره موبایل",
                  IconlyLight.call, false, TextInputType.phone),
              items(address, "آدرس", "آدرس", IconlyLight.location, false,
                  TextInputType.streetAddress),
              items(password, "رمز", "رمز", IconlyLight.password, false,
                  TextInputType.phone),
              const Spacer(),
              show_button
                  ? GestureDetector(
                      onTap: () {
                        create_user();
                        setState(() {
                          show_button = false;
                        });
                      },
                      child: Container(
                        height: myHeight * 0.07,
                        width: myWidth,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                          child: Text(
                            "ثبت نام",
                            style: TextStyle(color: theme.text),
                          ),
                        ),
                      ),
                    )
                  : const My_loading()
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
      MyMessage.mySnackbarMessage(context, "ثبت نام شما با موفقیت انجام شد", 1);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StartPage(),
          ));
    } else if (res.statusCode == 208) {
      MyMessage.mySnackbarMessage(context, "این شماره موبایل قبلا ثبت شده", 1);
      setState(() {
        show_button = false;
      });
    } else {
      MyMessage.mySnackbarMessage(
          context, 'در حال حاضر خطایی رخ داده لطفا بعدا امتحان کنید', 1);
      setState(() {
        show_button = false;
      });
    }
  }
}
