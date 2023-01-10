import 'package:flutter/material.dart';

class MyOpacityAnimation extends StatefulWidget {
  Widget? child;
  int? duration = 600;
  MyOpacityAnimation({super.key, this.child, this.duration});

  @override
  State<MyOpacityAnimation> createState() => _MyOpacityAnimationState();
}

class _MyOpacityAnimationState extends State<MyOpacityAnimation>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration!), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn));
    animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
          return Opacity(
            opacity: animation!.value,
            child: widget.child,
          );
        });
  }
}
