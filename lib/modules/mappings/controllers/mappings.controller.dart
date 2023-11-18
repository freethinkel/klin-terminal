import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klin/modules/mappings/models/default_shortcuts.dart';
import 'package:klin/modules/mappings/models/intents.dart';
import 'package:klin/modules/mappings/models/shortcuts.dart';
import 'package:klin/modules/mappings/services/shortcuts.service.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:rx_flow/rx_flow.dart';

class MappingController extends IController {
  MappingController({
    required ShortcutsService shortcutsService,
    required TabsController tabsController,
    required SettingsController settingsController,
  })  : _shortcutsService = shortcutsService,
        _tabsController = tabsController,
        _settingsController = settingsController;

  final ShortcutsService _shortcutsService;
  final TabsController _tabsController;
  final SettingsController _settingsController;

  final mappings = RxListStorage<CustomShortcut>(
    "mappings",
    initialValue: defaultShortcuts,
    mapper: (items) => items
        .map((decoded) => CustomShortcut.fromMap(json.decode(decoded)))
        .toList(),
  );

  @override
  void init() {
    _shortcutsService.registerShortcuts({...mappings.value ?? []});
    mappings.stream.listen((shortcuts) {
      _shortcutsService.registerShortcuts({...shortcuts});
    });

    _shortcutsService.onHandled = (key) {
      ({
        AppMappingActions.openSettings: () {
          _settingsController.openSettings();
        },
        AppMappingActions.newTab: () {
          _tabsController.addNewTab();
        },
        AppMappingActions.closeTab: () {
          _tabsController.closeTab(_tabsController.currentTab$.value!);
        },
        AppMappingActions.closeTerminal: () {
          _tabsController.currentTab$.value?.lastFocusedNode?.dispose();
        },
        AppMappingActions.focusNextTab: () {
          _tabsController.nextTab();
        },
        AppMappingActions.focusPrevTab: () {
          _tabsController.prevTab();
        },
        AppMappingActions.splitDown: () {
          _tabsController.currentTab$.value?.lastFocusedNode?.splitPane
              ?.call(Axis.vertical);
        },
        AppMappingActions.splitRight: () {
          _tabsController.currentTab$.value?.lastFocusedNode?.splitPane
              ?.call(Axis.horizontal);
        },
        AppMappingActions.selectTab1: () {
          _tabsController.switchToTab(0);
        },
        AppMappingActions.selectTab2: () {
          _tabsController.switchToTab(1);
        },
        AppMappingActions.selectTab3: () {
          _tabsController.switchToTab(2);
        },
        AppMappingActions.selectTab4: () {
          _tabsController.switchToTab(3);
        },
        AppMappingActions.selectTab5: () {
          _tabsController.switchToTab(4);
        },
        AppMappingActions.selectTab6: () {
          _tabsController.switchToTab(5);
        },
        AppMappingActions.selectTab7: () {
          _tabsController.switchToTab(6);
        },
        AppMappingActions.selectTab8: () {
          _tabsController.switchToTab(7);
        },
        AppMappingActions.selectTab9: () {
          _tabsController.switchToTab(8);
        },
      }[key.action])
          ?.call();

      if (key.sendChars?.isNotEmpty == true) {
        final chars = key.sendChars ?? "";
        final numbers = RegExp("\\x([0-9a-fA-F]){0,2}")
            .allMatches(chars)
            .map((e) => e[0]!.replaceAll('x', ''));
        final allChars = numbers
            .map((e) => String.fromCharCode(int.parse(e, radix: 16)))
            .join("");
        _tabsController.currentTab$.value?.lastFocusedNode?.sendChars(allChars);
      }
    };
  }

  void addKeymap(CustomShortcut shortcut) {
    var shortcuts = mappings.value ?? [];
    shortcuts.add(shortcut);
    mappings.next(shortcuts);
  }

  void removeKeymap(CustomShortcut shortcut) {
    var shortcuts = mappings.value ?? [];
    shortcuts.remove(shortcut);
    mappings.next(shortcuts);
  }

  void replaceShortcut(CustomShortcut oldShortcut, CustomShortcut newShortcut) {
    var shortcuts = mappings.value ?? [];
    shortcuts[shortcuts.indexOf(oldShortcut)] = newShortcut;

    mappings.next(shortcuts);
  }

  late final onKey = _shortcutsService.onKey;
  bool get handled => _shortcutsService.handled;
}
