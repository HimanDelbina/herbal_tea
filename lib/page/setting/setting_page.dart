import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool is_signin = false;
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

  bool change_theme = false;

  @override
  void initState() {
    super.initState();
    // check_shared_data_test();
    check_shared_data();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme_Bloc = Provider.of<ThemeBloc>(context);
    return Container(
      color: theme_Bloc.backgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        children: [
          ListTile(
            leading: Text(
              change_theme ? "light" : "dark",
              style: TextStyle(color: theme_Bloc.text),
            ),
            trailing: Switch(
                activeColor: const Color(0xff0F4C75),
                value: change_theme,
                onChanged: (bool value) {
                  setState(() {
                    change_theme = value;
                  });
                  check_shared_data_test();
                  change_theme
                      ? theme_Bloc.blackTheme()
                      : theme_Bloc.defaltTheme();
                }),
          )
        ],
      ),
    );
  }
}
