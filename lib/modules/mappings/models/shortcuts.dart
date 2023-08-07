import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:oshmes_terminal/modules/mappings/models/intents.dart';

enum TerminalAction {
  action("Internal action"),
  sendChars("Send custom chars to active terminal");

  const TerminalAction(this.description);
  final String description;
}

class CustomShortcut {
  CustomShortcut({
    this.activator,
    this.action,
    this.sendChars,
  });
  final SingleActivator? activator;
  final AppMappingActions? action;
  final String? sendChars;

  CustomShortcut copyWith({
    SingleActivator? activator,
    AppMappingActions? action,
    String? sendChars,
  }) {
    return CustomShortcut(
      activator: activator ?? this.activator,
      action: action ?? this.action,
      sendChars: sendChars ?? this.sendChars,
    );
  }

  Map<String, String> toMap() {
    final Map<String, String> map = {};
    final List<String> modifiers = [];

    if (activator != null) {
      map["key"] = activator!.trigger.keyLabel;
      modifiers.addAll([
        activator!.alt ? "alt" : null,
        activator!.meta ? "command" : null,
        activator!.control ? "control" : null,
        activator!.shift ? "shift" : null
      ].whereType<String>());
    }

    if (sendChars != null) {
      map["chars"] = sendChars!;
    }
    if (action != null) {
      map["action"] = action!.name;
    }

    map["mods"] = modifiers.join("|");

    return map;
  }

  static CustomShortcut fromMap(Map data) {
    var key = data["key"];
    var chars = data["chars"];
    var action = AppMappingActions.values.firstWhereIndexedOrNull(
        (_, element) => data["action"] == element.name);
    var logicalKey = LogicalKeyboardKey.knownLogicalKeys
        .firstWhereOrNull((element) => element.keyLabel == key);
    var rawMods = (data["mods"] ?? "").toString().toLowerCase();
    var mods = rawMods.split("|");

    var meta = mods.contains("command");
    var alt = mods.contains("alt");
    var control = mods.contains("control");
    var shift = mods.contains("shift");

    return CustomShortcut(
      activator: logicalKey == null
          ? null
          : SingleActivator(
              logicalKey,
              includeRepeats: false,
              meta: meta,
              shift: shift,
              alt: alt,
              control: control,
            ),
      action: action,
      sendChars: chars,
    );
  }

  @override
  String toString() {
    return json.encode(toMap());
  }
}
