import 'package:flutter/material.dart';
import 'package:sara_plant/components/error_page.dart';
import 'package:sara_plant/components/shared_helper.dart';
import 'package:sara_plant/components/user_static.dart';
import 'package:sara_plant/page/register/signup.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool is_signin = false;

  @override
  void initState() {
    super.initState();
    check_token();
  }

  void check_token() {
    if (SharedHelper.my_token == null) {
      setState(() {
        is_signin = false;
      });
    } else {
      SharedHelper.token_get();
      setState(() {
        is_signin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: is_signin
            ? signin()
            : ErrorPage(
                image: "assets/animation/user.json",
                // text: "لطفا برای استفاده ثبت نام کنید",
                is_rich: true,
                rich_text: "لطفا برای استفاده",
                rich_text_click: " ثبت نام ",
                rich_text2: "کنید",
                page: const SignUp()),
        // child: is_signin ? no_signin() : signin(),
      ),
    );
  }

  Widget no_signin() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // const Spacer(),
        Container(
          height: myHeight * 0.2,
          width: myWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                    "شما هنوز ثبت نام نکرده اید لطفا برای استفاده کامل ثبت نام خود را کامل کنید"),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text("ثبت نام",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget signin() {
    return Column(
      children: [
        Text(UserStaticFile.first_name.toString()),
        Text(UserStaticFile.last_name.toString()),
        Text(UserStaticFile.phone_number.toString()),
        Text(UserStaticFile.address.toString()),
      ],
    );
  }
}
