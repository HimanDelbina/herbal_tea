import 'package:flutter/material.dart';

class MyNumberScaleAnimation extends StatefulWidget {
  int? number;
  int? duration;
  TextStyle? style;
  MyNumberScaleAnimation({
    Key? key,
    this.number = 0,
    this.duration = 500,
    this.style,
  }) : super(key: key);

  @override
  State<MyNumberScaleAnimation> createState() => _MyNumberScaleAnimationState();
}

class _MyNumberScaleAnimationState extends State<MyNumberScaleAnimation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: widget.duration!),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Text(widget.number.toString(),
            key: ValueKey<int>(widget.number!), style: widget.style));
  }
}
