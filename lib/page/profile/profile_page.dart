import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sara_plant/components/error_page.dart';
import 'package:sara_plant/components/shared_helper.dart';
import 'package:sara_plant/components/user_static.dart';
import 'package:sara_plant/page/register/signup.dart';

import '../../provider/animation_controller.dart';

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
            ? Column(
                children: [
                  signin_profile(),
                  signin_setting(),
                ],
              )
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

  Widget signin_profile() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        width: myWidth,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text("پروفایل"),
                ],
              ),
              const Divider(),
              ListTile(
                trailing: const Icon(IconlyLight.edit_square),
                leading: const Icon(IconlyBold.profile),
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(UserStaticFile.first_name.toString()),
                    ),
                    Text(UserStaticFile.last_name.toString()),
                  ],
                ),
              ),
              ListTile(
                trailing: const Icon(IconlyLight.edit_square),
                leading: const Icon(IconlyBold.call),
                title: Text(UserStaticFile.phone_number.toString()),
              ),
              ListTile(
                trailing: const Icon(IconlyLight.edit_square),
                leading: const Icon(IconlyBold.location),
                title: Text(
                  UserStaticFile.address.toString(),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final MyAnimationController controller = MyAnimationController();
  bool is_theme = false;
  Widget signin_setting() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: myWidth,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text("تنظیمات"),
                  ],
                ),
                const Divider(),
                ListTile(
                  onTap: controller.updateTheme,
                  trailing: Switch(
                    value: controller.is_theme,
                    onChanged: (value) {
                      setState(() {
                        controller.is_theme = value;
                      });
                    },
                  ),
                  leading: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      switchInCurve: Curves.easeInOutBack,
                      child: controller.is_theme
                          ? const Text("تم تاریک", key: ValueKey("dark"))
                          : const Text("تم روشن", key: ValueKey("light"))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
