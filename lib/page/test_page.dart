import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/custom_transition.dart';
import 'package:sara_plant/provider/animation_controller.dart';
import '../provider/theme.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final MyAnimationController controller = MyAnimationController();
  bool is_select = false;

  Icon actionIcon = const Icon(IconlyLight.search);
  Widget appBarTitle = const Text("");
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xffF1F6F5),
          appBar: AppBar(
              iconTheme: IconThemeData(color: theme.iconItem),
              backgroundColor: Colors.transparent,
              leadingWidth: myWidth * 0.2,
              automaticallyImplyLeading: false,
              actions: [
                GestureDetector(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(IconlyLight.arrow_left_2),
                  ),
                ),
              ],
              elevation: 0.0),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        is_select = !is_select;
                      });
                    },
                    child: AnimatedContainer(
                      height: myHeight * 0.08,
                      width: is_select ? myWidth * 0.16 : myWidth,
                      curve: Curves.easeInOutBack,
                      duration: const Duration(milliseconds: 600),
                      decoration: BoxDecoration(
                          color: is_select
                              ? Colors.redAccent
                              : Colors.grey.withOpacity(0.1),
                          shape:
                              is_select ? BoxShape.circle : BoxShape.rectangle),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          child: is_select ? delete_data() : data(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: myHeight * 0.1,
                    width: myWidth,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     MyWidgetTransform(
                  //         axis: Axis.vertical,
                  //         duration: 1600,
                  //         curve: Curves.bounceIn,
                  //         child: const Text(" team ")),
                  //     MyWidgetTransform(
                  //         axis: Axis.vertical,
                  //         duration: 1400,
                  //         curve: Curves.bounceIn,
                  //         child: const Text("IO ")),
                  //     MyWidgetTransform(
                  //         axis: Axis.vertical,
                  //         duration: 1200,
                  //         curve: Curves.bounceIn,
                  //         child: const Text("by ")),
                  //     MyWidgetTransform(
                  //         axis: Axis.vertical,
                  //         duration: 1000,
                  //         curve: Curves.bounceIn,
                  //         child: const Text("product ")),
                  //   ],
                  // ),
                  animTest(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget animTest() {
    return DefaultTextStyle(
      style: const TextStyle(
          fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText('Product by IO Team'),
          // WavyAnimatedText('Look at the waves'),
        ],
        isRepeatingAnimation: false,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }

  Widget data() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text("data"),
        Icon(IconlyLight.delete, color: Colors.redAccent, size: 25.0)
      ],
    );
  }

  Widget delete_data() {
    return const Center(
        child: Icon(IconlyBold.delete, color: Colors.white, size: 25.0));
  }
}
