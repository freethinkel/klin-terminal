import 'package:flutter/widgets.dart';
import 'package:klin/modules/mappings/services/shortcuts.service.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:rx_flow/rx_flow.dart';
import 'package:window_manager/window_manager.dart';

class WindowManagerListeners extends WindowListener implements IService {
  WindowManagerListeners({
    required TabsController tabsController,
    required ShortcutsService shortcutsService,
  })  : _tabsController = tabsController,
        _shortcutsService = shortcutsService;
  final ShortcutsService _shortcutsService;
  final TabsController _tabsController;

  @override
  void onWindowBlur() {
    FocusManager.instance.primaryFocus?.unfocus();
    _shortcutsService.clearPressedKeys();
    super.onWindowBlur();
  }

  @override
  void onWindowFocus() {
    FocusManager.instance.primaryFocus?.requestFocus();
    _tabsController.currentTab$.value?.lastFocusedNode?.focusNode
        .requestFocus();
    super.onWindowFocus();
  }
}
