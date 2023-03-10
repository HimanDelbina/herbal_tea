import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/page/toturial/toturial_page.dart';
import 'package:sara_plant/static/message_static.dart';
import '../provider/theme.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? curveImage;
  Animation<double>? curveText;
  ColorTween? colorAnim;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    curveImage = CurvedAnimation(parent: controller!, curve: Curves.linear);
    curveText = CurvedAnimation(parent: controller!, curve: Curves.linear);
    colorAnim = ColorTween(begin: Colors.red, end: Colors.amber);
    controller!.forward();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ToturialPage()));
    });
  }

  bool change_theme = false;

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  int is_exit = 0;

  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    double myHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 500), () {
          is_exit = 0;
        });
        is_exit++;
        if (is_exit == 2) {
          exit(1);
        } else {
          MyMessage.mySnackbarMessage(context, "for_exit".tr(), 1);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: theme.backgroundColorSplash,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LottieBuilder.asset("assets/animation/splash2.json",
                      height: myHeight * 0.5, repeat: true),
                  animTextProduct(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget animTextProduct() {
    return DefaultTextStyle(
      textAlign: TextAlign.end,
      style: const TextStyle(
          fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(
            'Product by IO Team',
            speed: const Duration(milliseconds: 150),
          ),
        ],
        isRepeatingAnimation: false,
        onTap: () {},
      ),
    );
  }
}
