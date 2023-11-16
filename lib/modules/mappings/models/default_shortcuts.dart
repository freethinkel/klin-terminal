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
  ..._selectTabsShortcuts,
];

final _selectTabsShortcuts = [
  CustomShortcut(
    action: AppMappingActions.selectTab1,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit1,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab2,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit2,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab3,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit3,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab4,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit4,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab5,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit5,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab6,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit6,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab7,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit7,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab8,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit8,
      meta: true,
    ),
  ),
  CustomShortcut(
    action: AppMappingActions.selectTab9,
    activator: const SingleActivator(
      LogicalKeyboardKey.digit9,
      meta: true,
    ),
  ),
];
