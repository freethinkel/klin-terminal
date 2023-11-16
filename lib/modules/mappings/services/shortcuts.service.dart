import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klin/core/models/service.dart';
import 'package:klin/modules/mappings/models/shortcuts.dart';

class ShortcutsService extends IService {
  final Set<LogicalKeyboardKey> _pressedKeys = {};
  Set<CustomShortcut> _shortcuts = {};
  bool handled = false;

  Function(CustomShortcut shortcut)? onHandled;

  final originServiceBindingHandler =
      ServicesBinding.instance.keyEventManager.keyMessageHandler;

  void registerShortcuts(Set<CustomShortcut> shortcuts) {
    _shortcuts = shortcuts;
  }

  bool accepts(RawKeyEvent event, SingleActivator activator) {
    final Set<LogicalKeyboardKey> pressed = _pressedKeys;
    final control = activator.control;
    final shift = activator.shift;
    final alt = activator.alt;
    final meta = activator.meta;

    return event is RawKeyDownEvent &&
        activator.trigger == event.logicalKey &&
        (control ==
            (pressed.contains(LogicalKeyboardKey.controlLeft) ||
                pressed.contains(LogicalKeyboardKey.controlRight) ||
                pressed.contains(LogicalKeyboardKey.control))) &&
        (shift ==
            (pressed.contains(LogicalKeyboardKey.shiftLeft) ||
                pressed.contains(LogicalKeyboardKey.shiftRight) ||
                pressed.contains(LogicalKeyboardKey.shift))) &&
        (alt ==
            (pressed.contains(LogicalKeyboardKey.altLeft) ||
                pressed.contains(LogicalKeyboardKey.altRight) ||
                pressed.contains(LogicalKeyboardKey.alt))) &&
        (meta ==
            (pressed.contains(LogicalKeyboardKey.metaLeft) ||
                pressed.contains(LogicalKeyboardKey.metaRight) ||
                pressed.contains(LogicalKeyboardKey.meta)));
  }

  void onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    } else if (event is RawKeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
    }

    var found = _shortcuts.firstWhereOrNull(
      (shortcut) => shortcut.activator == null
          ? false
          : accepts(event, shortcut.activator!),
    );
    if (found != null &&
        event is RawKeyDownEvent &&
        found.activator?.includeRepeats == event.repeat) {
      onHandled?.call(found);
    }

    handled = found != null;
  }
}
