import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/search_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sara_plant/components/test_search.dart';
import '../provider/theme.dart';

class MySearch extends StatefulWidget {
  var data;
  var backup_data;
  String? value;
  TextEditingController? text_controller;
  MySearch({
    super.key,
    this.data,
    this.backup_data,
    this.value,
    this.text_controller,
  });

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Container(
        height: myHeight * 0.07,
        child: TextFormField(
            controller: widget.text_controller,
            onChanged: (value) {
              setState(() {
                widget.data = SearchComponent.search(
                    widget.backup_data, value, widget.value);
              });
            },
            cursorColor: theme.cursorSearch,
            decoration: InputDecoration(
                labelText: "serach".tr(),
                hintText: "serach".tr(),
                hintStyle: TextStyle(color: theme.unselectItem),
                labelStyle: TextStyle(color: theme.text),
                suffixIconColor: theme.iconItem,
                suffixIcon: Icon(IconlyLight.search, color: theme.iconItem),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.focusBorderSearch)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.enableBorderSearch)),
                border: const OutlineInputBorder())),
      ),
    );
  }
}
