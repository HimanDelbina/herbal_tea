import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/number_scale_animation.dart';
import 'package:sara_plant/provider/get_card.dart';
import '../../components/error_page.dart';
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
                  child: list_show_card_data())
              : const SignUpError()),
    );
  }

  int count = 1;
  var show_data = [];
  var show_data_Search = [];
  Widget list_show_card_data() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<CardGet>(
      builder: (context, value, child) {
        show_data = value.map;
        show_data_Search = value.map;
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
                                height: myHeight * 0.2,
                                width: myWidth,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(show_data[index].herbalTea.name),
                                        GestureDetector(
                                            onTap: () {},
                                            child: const Icon(IconlyBold.delete,
                                                color: Colors.redAccent))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyNumberScaleAnimation(
                                          is_price: true,
                                          price:
                                              show_data[index].herbalTea.price *
                                                  count,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    count = count + 1;
                                                  });
                                                },
                                                child: const Icon(
                                                    Icons.add_circle)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: MyNumberScaleAnimation(
                                                number: count,
                                                duration: 300,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  if (count == 1) {
                                                  } else {
                                                    setState(() {
                                                      count = count - 1;
                                                    });
                                                  }
                                                },
                                                child: const Icon(
                                                    Icons.remove_circle)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                      );
      },
    );
  }
}
