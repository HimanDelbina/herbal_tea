import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingComponent extends StatefulWidget {
  const LoadingComponent({Key? key}) : super(key: key);

  @override
  State<LoadingComponent> createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Lottie.asset('assets/animation/loading_black.json', height: 30.0),
      ],
    );
  }
}
