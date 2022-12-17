import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/shared_helper.dart';
import 'package:sara_plant/page/card/card_page.dart';
import 'package:sara_plant/page/faviorate/faviorate_page.dart';
import 'package:sara_plant/page/home/home.dart';
import 'package:sara_plant/page/profile/profile_page.dart';
import 'package:sara_plant/provider/animation_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/my_drawer.dart';
import '../provider/theme.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavioratePage(),
    CardPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    controller.onButtomNavigationBarTabChange(index);
  }

  void check_shared_data() async {
    bool theme;
    SharedPreferences pref = await SharedPreferences.getInstance();
    final get_theme = pref.getBool("theme");
    setState(() {
      change_theme = get_theme!;
    });
    final ThemeBloc theme_Bloc = Provider.of<ThemeBloc>(context, listen: false);
    change_theme ? theme_Bloc.blackTheme() : theme_Bloc.defaltTheme();
  }

  void check_shared_data_test() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("theme", change_theme);
  }

  bool change_theme = false;

  void shared_get_token() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    SharedHelper.my_token = pref.getString("token");
    if (SharedHelper.my_token != null) {
      SharedHelper.check_token();
    }
  }

  @override
  void initState() {
    super.initState();
    check_shared_data();
    shared_get_token();
  }

  bool? swith_theme = false;

  final MyAnimationController controller = MyAnimationController();
  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          drawer: const MyDrawer(),
          appBar: AppBar(
              iconTheme: IconThemeData(color: theme.iconDrawer),
              backgroundColor: theme.backgroundColor,
              actions: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      change_theme = !change_theme;
                    });
                    check_shared_data_test();
                    change_theme ? theme.blackTheme() : theme.defaltTheme();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                        child: change_theme
                            ? Image.asset("assets/image/light.png",
                                height: 30.0)
                            : Image.asset("assets/image/light.png",
                                height: 30.0, color: Colors.black)),
                  ),
                ),
                GestureDetector(
                  onTap: controller.updateTheme,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      switchInCurve: Curves.easeInOutBack,
                      child: controller.is_theme
                          ? Image.asset("assets/image/light.png",
                              height: 30.0, key: const ValueKey("light"))
                          : Image.asset("assets/image/light.png",
                              height: 30.0,
                              color: Colors.black,
                              key: const ValueKey("dark")),
                    ),
                  ),
                ),
              ],
              elevation: 0.0),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: theme.backgroundColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: theme.iconNavbarSelect,
              unselectedItemColor: theme.iconNavbarUnSelect,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme: const IconThemeData(size: 27.0),
              unselectedIconTheme: const IconThemeData(size: 23.0),
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: "خانه",
                  icon: Icon(
                      _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                ),
                BottomNavigationBarItem(
                  label: "مورد علاقه ها",
                  icon: Icon(_selectedIndex == 1
                      ? IconlyBold.bookmark
                      : IconlyLight.bookmark),
                ),
                BottomNavigationBarItem(
                  label: "سبد خرید",
                  icon: Icon(
                      _selectedIndex == 2 ? IconlyBold.bag : IconlyLight.bag),
                ),
                BottomNavigationBarItem(
                  label: "پروفایل",
                  icon: Icon(_selectedIndex == 3
                      ? IconlyBold.profile
                      : IconlyLight.profile),
                ),
              ]),
        );
      },
    );
  }
}
