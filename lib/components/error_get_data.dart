import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class My_loading extends StatelessWidget {
  const My_loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Lottie.asset("assets/animation/loading_black.json",
                height: 30.0),
          ),
        ],
      ),
    );
  }
}
