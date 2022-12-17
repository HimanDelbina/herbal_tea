import 'package:flutter/material.dart';

class MyWidgetTransform extends StatefulWidget {
  final Widget? child;
  final double? offset;
  final int? duration;
  final Curve? curve;
  final Axis? axis;
  MyWidgetTransform({
    Key? key,
    this.child,
    this.offset = 140.0,
    this.duration = 800,
    this.curve = Curves.elasticOut,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  State<MyWidgetTransform> createState() => _MyWidgetTransformState();
}

class _MyWidgetTransformState extends State<MyWidgetTransform> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: widget.duration!),
      tween: Tween(begin: 10.0, end: 0.0),
      curve: widget.curve!,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return Transform.translate(
          offset: widget.axis! == Axis.horizontal
              ? Offset(value * widget.offset, 0.0)
              : Offset(0.0, value * widget.offset),
          child: widget.child,
        );
      },
    );
  }
}
