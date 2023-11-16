import 'package:klin/core/app/app.dart';
import 'package:klin/core/widgets/controller_connector.dart';
import 'package:klin/modules/channel/controllers/channel.controller.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'core/di/locator.dart' as locator;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();

  locator.setup();

  ControllerConnector.of<ChannelController>().init();
  await ControllerConnector.of<ThemeController>().init();

  WindowManager.instance.addListener(WindowManagerListeners(
    tabsController: locator.locator.get(),
  ));

  runApp(const App());
}

class WindowManagerListeners extends WindowListener {
  WindowManagerListeners({required TabsController tabsController})
      : _tabsController = tabsController;
  final TabsController _tabsController;

  @override
  void onWindowBlur() {
    FocusManager.instance.primaryFocus?.unfocus();
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
