import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_page.dart';
import '../../provider/theme.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return ErrorPage(
        image: "assets/animation/empty.json",
        text: "سبد خرید شما خالی است",
        is_rich: false);
  }
}
