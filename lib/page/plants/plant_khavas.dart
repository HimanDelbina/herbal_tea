import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sara_plant/components/error_get_data.dart';
import '../../provider/theme.dart';

class PlantKhavas extends StatefulWidget {
  var data;
  PlantKhavas({super.key, this.data});

  @override
  State<PlantKhavas> createState() => _PlantKhavasState();
}

class _PlantKhavasState extends State<PlantKhavas> {
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
              ? const ErrorGetData()
              : ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return item_show(
                        widget.data[index].name, (index + 1).toString());
                  },
                ),
        ),
      ),
    );
  }

  Widget item_show(String data, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            children: [
              Text(number, style: const TextStyle(color: Colors.green)),
              const SizedBox(width: 5.0),
              const Text(" : "),
              Expanded(child: Text(data, softWrap: true)),
            ],
          ),
        ),
      ),
    );
  }
}
