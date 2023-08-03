import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oshmes_terminal/core/models/service.dart';
import 'package:oshmes_terminal/modules/mappings/models/shortcuts.dart';

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
    final includeRepeats = activator.includeRepeats;
    final control = activator.control;
    final shift = activator.shift;
    final alt = activator.alt;
    final meta = activator.meta;

    return event is RawKeyDownEvent &&
        activator.trigger == event.logicalKey &&
        (includeRepeats || !event.repeat) &&
        (control ==
            (pressed.contains(LogicalKeyboardKey.controlLeft) ||
                pressed.contains(LogicalKeyboardKey.controlRight))) &&
        (shift ==
            (pressed.contains(LogicalKeyboardKey.shiftLeft) ||
                pressed.contains(LogicalKeyboardKey.shiftRight))) &&
        (alt ==
            (pressed.contains(LogicalKeyboardKey.altLeft) ||
                pressed.contains(LogicalKeyboardKey.altRight))) &&
        (meta ==
            (pressed.contains(LogicalKeyboardKey.metaLeft) ||
                pressed.contains(LogicalKeyboardKey.metaRight)));
  }

  void onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    } else if (event is RawKeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
    }

    var found = _shortcuts.firstWhereOrNull(
      (shortcut) => accepts(event, shortcut.activator),
    );
    if (found != null) {
      onHandled?.call(found);
    }

    handled = found != null;
  }
}
