import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import '../../provider/theme.dart';

class HerbalTeaKhavas extends StatefulWidget {
  var data;
  HerbalTeaKhavas({super.key, this.data});

  @override
  State<HerbalTeaKhavas> createState() => _HerbalTeaKhavasState();
}

class _HerbalTeaKhavasState extends State<HerbalTeaKhavas> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: widget.data.length == 0
              ? const My_loading()
              : ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return item_show(widget.data[index].name,
                        widget.data[index].description, index + 1);
                  },
                ),
        ),
      ),
    );
  }

  Widget item_show(String title, String description, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ExpansionTile(
        textColor: Colors.green,
        iconColor: Colors.green,
        backgroundColor: Colors.greenAccent.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        initiallyExpanded: false,
        title: Text(title,
            style:
                const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
        leading:
            Text(index.toString(), style: const TextStyle(color: Colors.green)),
        children: [
          ListTile(
              title: Text(description,
                  style: const TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.justify))
        ],
      ),
    );
  }
}
