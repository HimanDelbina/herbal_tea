import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import 'package:sara_plant/components/helper.dart';
import 'package:sara_plant/components/hover_image_animation.dart';
import 'package:sara_plant/page/start_page.dart';
import '../../provider/get_toturial.dart';
import '../../provider/theme.dart';

class ToturialPage extends StatefulWidget {
  const ToturialPage({Key? key}) : super(key: key);

  @override
  State<ToturialPage> createState() => _ToturialPageState();
}

class _ToturialPageState extends State<ToturialPage> {
  int _currentPage = 0;
  PageController _controller = PageController();
  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    context.read<PlantToturiaGet>().fetchData;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Consumer<PlantToturiaGet>(builder: (context, value, child) {
          return value.map.length == 0 && !value.error
              ? const My_loading()
              : value.error
                  ? Text(value.errorMessage.toString())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _controller,
                              onPageChanged: _onChanged,
                              itemCount: value.map.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Container(
                                      height: myHeight * 0.4,
                                      padding: const EdgeInsets.all(30.0),
                                      child: Center(
                                          child: MyHoverImageAnimation(
                                        image_size: 200.0,
                                        y_shake: false,
                                        image: value.map[index].image == null
                                            ? ""
                                            : Helper.imageUrl +
                                                value.map[index].image!,
                                      ))),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Row(
                                            children: [
                                              Text(value.map[index].title!,
                                                  style: TextStyle(
                                                      color: theme.titleText,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0))
                                            ],
                                          )),
                                      Text(value.map[index].description!,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15.0,
                                              color: theme.text)),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  children: List<Widget>.generate(
                                      value.map.length, (int index) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 4.0,
                                  width: (index == _currentPage) ? 45.0 : 4.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 30.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: (index == _currentPage)
                                          ? theme.animatedContainerToturial
                                          : theme.animatedContainerToturial
                                              .withOpacity(0.5)),
                                );
                              })),
                              Expanded(
                                  child: Container(
                                height: myHeight * 0.07,
                                child: (_currentPage == (value.map.length - 1))
                                    ? go_to_app()
                                    : page_next(),
                              ))
                            ],
                          )
                        ],
                      ),
                    );
        }),
      ),
    );
  }

  Widget page_next() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              _controller.previousPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutQuint);
            },
            child: Container(
              height: myHeight * 0.05,
              width: myWidth * 0.2,
              decoration: BoxDecoration(
                  color: theme.nextBackButton,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Center(
                  child: Text("قبلی",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: theme.text))),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _controller.nextPage(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutQuint);
          },
          child: Container(
            height: myHeight * 0.05,
            width: myWidth * 0.2,
            decoration: BoxDecoration(
                color: theme.nextBackButton,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
                child: Text("بعدی",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: theme.text))),
          ),
        ),
      ],
    );
  }

  Widget go_to_app() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StartPage()));
          },
          child: Container(
            height: myHeight * 0.05,
            width: myWidth * 0.2,
            decoration: BoxDecoration(
                color: theme.nextBackButton,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
                child: Text("ورود",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: theme.text))),
          ),
        ),
      ],
    );
  }
}
