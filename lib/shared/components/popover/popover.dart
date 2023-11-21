import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

class Popover extends StatefulWidget {
  const Popover({
    required this.head,
    this.popover,
    this.onOpen,
    this.width,
    this.disabled = false,
    super.key,
  });
  final Widget head;
  final Widget? popover;
  final bool disabled;
  final double? width;
  final Function(bool)? onOpen;

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: () async {
        if (widget.disabled == true) {
          return;
        }
        widget.onOpen?.call(true);
        await openDialog(context);
        widget.onOpen?.call(false);
      },
      child: widget.head,
    );
  }

  Future<void> openDialog(BuildContext context) async {
    final RenderBox button = context.findRenderObject()! as RenderBox;

    await showGeneralDialog(
      context: context,
      barrierLabel: "Popover",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, __, ___) {
        final points = button.localToGlobal(Offset.zero);
        final top = points.dy + button.size.height;
        final left = points.dx + 10;
        final maxHeight = (MediaQuery.of(context).size.height -
                top -
                MediaQuery.of(context).viewPadding.bottom -
                10)
            .clamp(0.0, 210.0);
        final maxWidth = MediaQuery.of(context).size.width -
            left -
            MediaQuery.of(context).viewPadding.left;

        return PopoverBody(
          position: Offset(
            points.dx,
            top,
          ),
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          width: button.size.width,
          child: widget.popover,
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(0, -0.01), end: Offset.zero);

        return SlideTransition(
          position: tween.animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}

class PopoverBody extends StatelessWidget {
  const PopoverBody({
    required this.child,
    required this.position,
    this.width,
    this.maxHeight,
    this.maxWidth,
    super.key,
  });

  final Offset position;
  final double? maxHeight;
  final double? maxWidth;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(children: [
        Positioned(
          top: position.dy,
          left: position.dx,
          child: IntrinsicWidth(
            stepWidth: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: min(width ?? maxWidth ?? double.infinity,
                    maxWidth ?? double.infinity),
                minHeight: 0,
                maxHeight: maxHeight ?? double.infinity,
              ),
              child: SizedBox(width: width, child: child),
            ),
          ),
        ),
      ]),
    );
  }
}
