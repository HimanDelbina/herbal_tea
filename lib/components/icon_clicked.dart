import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MyFaviorateIcon extends StatefulWidget {
  bool? is_fave;
  MyFaviorateIcon({super.key, this.is_fave});

  @override
  State<MyFaviorateIcon> createState() => _MyFaviorateIconState();
}

class _MyFaviorateIconState extends State<MyFaviorateIcon> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      switchInCurve: Curves.easeInOutBack,
      child: widget.is_fave == true
          ? const Icon(IconlyBold.bookmark, key: ValueKey("bold"))
          : const Icon(IconlyLight.bookmark, key: ValueKey("light")),
    );
  }
}
