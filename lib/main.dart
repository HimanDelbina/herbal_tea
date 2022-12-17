import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/start_page.dart';
import 'package:sara_plant/page/test_page.dart';
import 'page/cheack_net.dart';
import 'provider/check_internet.dart';
import 'page/splash_page.dart';
import 'provider/get_herbaltea.dart';
import 'provider/get_plant.dart';
import 'provider/get_sick.dart';
import 'provider/get_toturial.dart';
import 'provider/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      saveLocale: true,
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'EN'),
      ],
      path: "assets/resourse",
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _messangerKey = GlobalKey<ScaffoldMessengerState>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider<ThemeBloc>.value(value: ThemeBloc()),
        ChangeNotifierProvider<PlantToturiaGet>.value(value: PlantToturiaGet()),
        ChangeNotifierProvider<PlantGet>.value(value: PlantGet()),
        ChangeNotifierProvider<SickGet>.value(value: SickGet()),
        ChangeNotifierProvider<HerbalTeaGet>.value(value: HerbalTeaGet()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: _messangerKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'flutter_plant',
        theme: ThemeData(fontFamily: "Vazir"),
        // home: const CheckNet(),
        home: const StartPage(),
        // home: const TestPage(),
      ),
    );
  }
}
