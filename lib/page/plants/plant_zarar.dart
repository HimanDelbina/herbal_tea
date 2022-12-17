import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/error_get_data.dart';
import '../../provider/theme.dart';

class PlantZarar extends StatefulWidget {
  var data;
  PlantZarar({super.key, this.data});

  @override
  State<PlantZarar> createState() => _PlantZararState();
}

class _PlantZararState extends State<PlantZarar> {
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
              Text(number, style: const TextStyle(color: Colors.redAccent)),
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
