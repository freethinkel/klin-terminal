import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oshmes_terminal/core/models/controller.dart';
import 'package:oshmes_terminal/core/models/rx_storage.dart';
import 'package:oshmes_terminal/modules/mappings/models/intents.dart';
import 'package:oshmes_terminal/modules/mappings/models/shortcuts.dart';
import 'package:oshmes_terminal/modules/mappings/services/shortcuts.service.dart';
import 'package:oshmes_terminal/modules/tabs/controllers/tabs.controller.dart';

class MappingController extends IController {
  MappingController({
    required ShortcutsService shortcutsService,
    required TabsController tabsController,
  })  : _shortcutsService = shortcutsService,
        _tabsController = tabsController;

  final ShortcutsService _shortcutsService;
  final TabsController _tabsController;

  final mappings = RxListStorage<CustomShortcut>(
    "mappings",
    initialValue: [],
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
        AppMappingActions.newTab: () {
          _tabsController.addNewTab();
        },
        AppMappingActions.closeTab: () {
          _tabsController.closeTab(_tabsController.currentTab$.value!);
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
