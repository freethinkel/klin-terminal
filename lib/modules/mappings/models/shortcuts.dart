import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomShortcut {
  CustomShortcut({
    required this.activator,
    this.sendChars,
  });
  final SingleActivator activator;
  final String? sendChars;

  static CustomShortcut fromMap(Map data) {
    var key = data["key"];
    var chars = data["chars"] ?? "";
    var logicalKey = LogicalKeyboardKey.knownLogicalKeys
        .firstWhereOrNull((element) => element.keyLabel == key);
    var rawMods = (data["mods"] ?? "").toString().toLowerCase();
    var mods = rawMods.split("|");

    var meta = mods.contains("command");
    var alt = mods.contains("alt");
    var control = mods.contains("control");
    var shift = mods.contains("shift");

    return CustomShortcut(
      activator: SingleActivator(
        logicalKey!,
        meta: meta,
        shift: shift,
        alt: alt,
        control: control,
      ),
      sendChars: chars,
    );
  }
}
