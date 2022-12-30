import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_page.dart';
import 'package:sara_plant/static/shared_helper.dart';
import 'package:sara_plant/static/user_static.dart';
import 'package:sara_plant/page/register/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/animation_controller.dart';
import 'package:easy_localization/src/public_ext.dart';

import '../../provider/theme.dart';

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
    check_shared_data();
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
    ThemeBloc theme_Bloc = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        width: myWidth,
        decoration: BoxDecoration(
            color: theme_Bloc.items, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("پروفایل",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: theme_Bloc.text)),
                ],
              ),
              const Divider(),
              ListTile(
                // tileColor: theme_Bloc.items,
                trailing:
                    Icon(IconlyLight.edit_square, color: theme_Bloc.iconItem),
                leading: Icon(IconlyBold.profile, color: theme_Bloc.iconItem),
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        UserStaticFile.first_name.toString(),
                        style: TextStyle(color: theme_Bloc.text),
                      ),
                    ),
                    Text(
                      UserStaticFile.last_name.toString(),
                      style: TextStyle(color: theme_Bloc.text),
                    ),
                  ],
                ),
              ),
              ListTile(
                // tileColor: theme_Bloc.items,
                trailing:
                    Icon(IconlyLight.edit_square, color: theme_Bloc.iconItem),
                leading: Icon(IconlyBold.call, color: theme_Bloc.iconItem),
                title: Text(
                  UserStaticFile.phone_number.toString(),
                  style: TextStyle(color: theme_Bloc.text),
                ),
              ),
              ListTile(
                // tileColor: theme_Bloc.items,
                trailing:
                    Icon(IconlyLight.edit_square, color: theme_Bloc.iconItem),
                leading: Icon(IconlyBold.location, color: theme_Bloc.iconItem),
                title: Text(
                  UserStaticFile.address.toString(),
                  style: TextStyle(color: theme_Bloc.text),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool change_theme = false;
  void check_shared_data() async {
    bool theme;
    SharedPreferences pref = await SharedPreferences.getInstance();
    final get_theme = pref.getBool("theme");
    setState(() {
      change_theme = get_theme!;
    });
    final ThemeBloc theme_Bloc = Provider.of<ThemeBloc>(context, listen: false);
    change_theme ? theme_Bloc.blackTheme() : theme_Bloc.defaltTheme();
    print("himan theme test ======================" + get_theme.toString());
  }

  void check_shared_data_test() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("theme", change_theme);
  }

  final MyAnimationController controller = MyAnimationController();
  bool is_theme = false;
  Widget signin_setting() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme_Bloc = Provider.of<ThemeBloc>(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: myWidth,
          decoration: BoxDecoration(
              color: theme_Bloc.items,
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("تنظیمات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme_Bloc.text)),
                  ],
                ),
                const Divider(),
                ListTile(
                  // tileColor: theme_Bloc.items,
                  onTap: controller.updateTheme,
                  trailing: Switch(
                    value: change_theme,
                    onChanged: (value) {
                      setState(() {
                        change_theme = value;
                      });
                      check_shared_data_test();
                      change_theme
                          ? theme_Bloc.blackTheme()
                          : theme_Bloc.defaltTheme();
                    },
                  ),
                  leading: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      switchInCurve: Curves.easeInOutBack,
                      child: controller.is_theme
                          ? Text("تم تاریک",
                              style: TextStyle(color: theme_Bloc.text),
                              key: const ValueKey("dark"))
                          : Text("تم روشن",
                              style: TextStyle(color: theme_Bloc.text),
                              key: const ValueKey("light"))),
                ),
                ListTile(
                  onTap: controller.updatelanguage,
                  trailing: Switch(
                    value: controller.is_lan,
                    onChanged: (value) {
                      setState(() {
                        controller.is_lan = value;
                      });
                    },
                  ),
                  leading: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      switchInCurve: Curves.easeInOutBack,
                      child: controller.is_lan
                          ? Text("فارسی",
                              style: TextStyle(color: theme_Bloc.text),
                              key: const ValueKey("persian"))
                          : Text("انگلیسی",
                              style: TextStyle(color: theme_Bloc.text),
                              key: const ValueKey("english"))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
