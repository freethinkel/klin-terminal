import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:klin/modules/mappings/models/intents.dart';
import 'package:klin/modules/mappings/models/shortcuts.dart';

final List<CustomShortcut> defaultShortcuts = [
  CustomShortcut(
    action: AppMappingActions.newTab,
    activator: const SingleActivator(LogicalKeyboardKey.keyT, meta: true),
  ),
  CustomShortcut(
    action: AppMappingActions.closeTab,
    activator: const SingleActivator(LogicalKeyboardKey.keyW, meta: true),
  ),
  CustomShortcut(
    action: AppMappingActions.openSettings,
    activator: const SingleActivator(LogicalKeyboardKey.comma, meta: true),
  ),
  CustomShortcut(
    action: AppMappingActions.focusNextTab,
    activator: const SingleActivator(
      LogicalKeyboardKey.braceRight,
      meta: true,
      shift: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.focusPrevTab,
    activator: const SingleActivator(
      LogicalKeyboardKey.braceLeft,
      meta: true,
      shift: true,
    ),
  ),
];
