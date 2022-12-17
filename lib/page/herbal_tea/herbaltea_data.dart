import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/error_get_data.dart';
import '../../provider/theme.dart';

class HerbalTeaData extends StatefulWidget {
  List? data;
  List? image;
  String? description;
  HerbalTeaData({Key? key, this.data, this.image, this.description})
      : super(key: key);

  @override
  State<HerbalTeaData> createState() => _HerbalTeaDataState();
}

class _HerbalTeaDataState extends State<HerbalTeaData> {
  @override
  void initState() {
    super.initState();
    // get_all_dat_plant(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
    return Scaffold(
      body: widget.data!.length == 0
          ? const My_loading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        // Image.network(widget.image!),
                        Text(widget.description!, textAlign: TextAlign.justify),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
