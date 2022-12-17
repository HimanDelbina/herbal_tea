import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/theme.dart';

class ErrorPage extends StatefulWidget {
  @required
  String? text;
  @required
  String? image;
  bool? is_rich = false;
  Widget? widget;
  String? rich_text;
  String? rich_text_click;
  String? rich_text2;
  Widget? page;
  ErrorPage({
    Key? key,
    this.text,
    this.image,
    this.is_rich,
    this.widget,
    this.rich_text,
    this.rich_text_click,
    this.rich_text2,
    this.page,
  }) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Lottie.asset(widget.image!),
            )),
            widget.is_rich == false
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      widget.text!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ))
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: RichText(
                      text: TextSpan(
                        text: widget.rich_text,
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => widget.page!,
                                      ));
                                },
                              text: widget.rich_text_click,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent)),
                          TextSpan(text: widget.rich_text2),
                        ],
                      ),
                    ))
          ],
        ));
  }
}
