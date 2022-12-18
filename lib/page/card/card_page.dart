import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/number_scale_animation.dart';
import 'package:sara_plant/provider/get_card.dart';
import '../../components/error_page.dart';
import '../../components/image_slider.dart';
import '../../components/sign_up_error.dart';
import '../../components/user_static.dart';
import '../../provider/theme.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int time_for_show_data = 0;
  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    context.read<CardGet>().fetchData;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: UserStaticFile.user_id != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: list_show_card_data(),
              )
            : const SignUpError(),
      ),
    );
  }

  // List<int> count = [];
  bool cross_fade = false;
  var show_data = [];
  var count_final = [];
  var show_data_Search = [];
  Widget list_show_card_data() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<CardGet>(
      builder: (context, value, child) {
        show_data = value.map;
        show_data_Search = value.map;
        for (var i = 0; i < show_data.length; i++) {
          count_final.add(show_data[i].count);
        }
        return value.show_data == 0
            ? const My_loading()
            : value.show_data == 404
                ? ErrorPage(
                    image: "assets/animation/404-1.json",
                    text: "ارتباط با سرور برقرار نیست",
                    is_rich: false)
                : value.map.length == 0
                    ? ErrorPage(
                        image: "assets/animation/empty.json",
                        text: "سبد خرید شما خالی است",
                        is_rich: false)
                    : ListView.builder(
                        itemCount: show_data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                                height: myHeight * 0.13,
                                width: myWidth,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: myHeight,
                                      width: myWidth * 0.25,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                show_data[index].herbalTea.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: const Icon(
                                                  IconlyBold.delete,
                                                  color: Colors.redAccent,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("قیمت : "),
                                                  MyNumberScaleAnimation(
                                                    duration: 150,
                                                    is_price: true,
                                                    price: show_data[index]
                                                            .herbalTea
                                                            .price *
                                                        count_final[index],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          count_final[index] =
                                                              count_final[
                                                                      index] +
                                                                  1;
                                                          cross_fade = true;
                                                        });
                                                      },
                                                      child: Image.asset(
                                                          "assets/image/add.png",
                                                          height: 20.0)),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10.0,
                                                    ),
                                                    child:
                                                        MyNumberScaleAnimation(
                                                      number:
                                                          count_final[index],
                                                      duration: 300,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (count_final[index] ==
                                                          1) {
                                                      } else {
                                                        setState(() {
                                                          count_final[index] =
                                                              count_final[
                                                                      index] -
                                                                  1;
                                                          cross_fade = true;
                                                        });
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      "assets/image/remove.png",
                                                      height: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                      );
      },
    );
  }

  Widget image_show(var data) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Center(
        child: CircleAvatar(
            maxRadius: 30.0,
            backgroundColor: Colors.greenAccent.withOpacity(0.5)),
      ),
      const Center(
          child: CircleAvatar(maxRadius: 29.0, backgroundColor: Colors.white)),
      Center(
        child: CircleAvatar(
            maxRadius: 28.0,
            backgroundColor: Colors.greenAccent.withOpacity(0.2)),
      ),
      Positioned(child: ImageSliderHerbalTea(data: data.imageHerbaltea))
    ]);
  }
}
