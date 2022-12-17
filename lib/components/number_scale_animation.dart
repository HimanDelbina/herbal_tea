import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class MyNumberScaleAnimation extends StatefulWidget {
  int? number;
  int? duration;
  TextStyle? style;
  bool? is_price;
  double? price;
  MyNumberScaleAnimation({
    Key? key,
    this.number = 0,
    this.duration = 500,
    this.style,
    this.is_price = false,
    this.price,
  }) : super(key: key);

  @override
  State<MyNumberScaleAnimation> createState() => _MyNumberScaleAnimationState();
}

class _MyNumberScaleAnimationState extends State<MyNumberScaleAnimation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: widget.duration!),
        transitionBuilder: widget.is_price!
            ? (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation.status == AnimationStatus.dismissed
                        ? Tween<double>(begin: .5, end: 1).animate(animation)
                        : const AlwaysStoppedAnimation(1.0),
                    child: child,
                  ),
                );
              }
            : (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
        child: widget.is_price!
            ? Text(widget.price.toString().toPersianDigit().seRagham(),
                key: ValueKey<double>(widget.price!), style: widget.style)
            : Text(widget.number.toString(),
                key: ValueKey<int>(widget.number!), style: widget.style));
  }
}
