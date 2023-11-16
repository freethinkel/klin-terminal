import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogicalKeyRepresentation extends StatelessWidget {
  final LogicalKeyboardKey keyboardKey;
  const LogicalKeyRepresentation({
    required this.keyboardKey,
    super.key,
  });

  String toIcon() {
    if ([
      LogicalKeyboardKey.meta,
      LogicalKeyboardKey.metaLeft,
      LogicalKeyboardKey.metaRight
    ].contains(keyboardKey)) {
      return "⌘";
    }
    if ([
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.shiftRight
    ].contains(keyboardKey)) {
      return "⇧";
    }
    if ([
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.altLeft,
      LogicalKeyboardKey.altRight
    ].contains(keyboardKey)) {
      return "⌥";
    }
    if ([
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.controlLeft,
      LogicalKeyboardKey.controlRight
    ].contains(keyboardKey)) {
      return "^";
    }
    return keyboardKey.keyLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Text(toIcon());
  }
}
