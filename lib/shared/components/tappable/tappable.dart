import 'package:flutter/material.dart';

class Tappable extends StatelessWidget {
  const Tappable({
    required this.child,
    this.onTap,
    this.onTapUp,
    this.onHover,
    this.onPressed,
    super.key,
  });
  final Widget child;
  final Function()? onTap;
  final Function()? onTapUp;
  final Function(bool)? onHover;
  final Function(bool)? onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onHover?.call(true),
      onExit: (_) => onHover?.call(false),
      child: GestureDetector(
        onTapDown: (_) => onPressed?.call(true),
        onTapUp: (_) {
          onTapUp?.call();
          onPressed?.call(false);
        },
        onTapCancel: () => onPressed?.call(false),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
