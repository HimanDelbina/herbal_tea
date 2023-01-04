import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/card/card_page.dart';
import 'package:sara_plant/page/faviorate/faviorate_page.dart';
import 'package:sara_plant/page/home/home.dart';
import 'package:sara_plant/page/message/message_page.dart';
import 'package:sara_plant/page/profile/profile_page.dart';
import 'package:sara_plant/provider/animation_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/my_drawer.dart';
import '../provider/theme.dart';
import '../static/shared_helper.dart';
import 'package:easy_localization/src/public_ext.dart';

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
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
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
                MyMessage(),
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
                  label: "home".tr(),
                  icon: Icon(
                      _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                ),
                BottomNavigationBarItem(
                  label: "faviorate".tr(),
                  icon: Icon(_selectedIndex == 1
                      ? IconlyBold.bookmark
                      : IconlyLight.bookmark),
                ),
                BottomNavigationBarItem(
                  label: "shop".tr(),
                  icon: Icon(
                      _selectedIndex == 2 ? IconlyBold.bag : IconlyLight.bag),
                ),
                BottomNavigationBarItem(
                  label: "profile".tr(),
                  icon: Icon(_selectedIndex == 3
                      ? IconlyBold.profile
                      : IconlyLight.profile),
                ),
              ]),
        );
      },
    );
  }

  Widget MyMessage() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MessagePage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: Container(
            height: myHeight * 0.04,
            width: myWidth * 0.08,
            child: Stack(
              children: [
                const Center(child: Icon(IconlyLight.message)),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: myHeight * 0.02,
                    width: myWidth * 0.04,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.redAccent),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
