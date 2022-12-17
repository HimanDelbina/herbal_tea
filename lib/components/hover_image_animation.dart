import 'package:flutter/material.dart';

class MyHoverImageAnimation extends StatefulWidget {
  String? image;
  double? image_size;
  double? offset;
  bool? y_shake;
  bool? second_duration;
  int? duration;
  MyHoverImageAnimation(
      {Key? key,
      required this.image,
      this.image_size = 50.0,
      this.offset = 0.04,
      this.y_shake = true,
      this.duration = 700})
      : super(key: key);

  @override
  State<MyHoverImageAnimation> createState() => _MyHoverImageAnimationState();
}

class _MyHoverImageAnimationState extends State<MyHoverImageAnimation>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? animation;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration!),
    )..repeat(reverse: true);
    animation = Tween(
            begin: const Offset(0, 0),
            end: Offset(widget.y_shake == true ? widget.offset! : 0,
                widget.y_shake == true ? 0 : widget.offset!))
        .animate(controller!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: animation!,
        child: Image.network(widget.image!, height: widget.image_size));
  }
}
