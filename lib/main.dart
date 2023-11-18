import 'package:klin/core/app/app.dart';
import 'package:klin/modules/channel/controllers/channel.controller.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:klin/shared/controller/window_manager.controller.dart';
import 'package:rx_flow/rx_flow.dart';
import 'package:window_manager/window_manager.dart';

import 'core/di/locator.dart' as locator;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();

  locator.setup();

  locator.locator.get<ChannelController>().init();
  await locator.locator.get<ThemeController>().init();
  locator.locator.get<MappingController>().init();

  WindowManager.instance.addListener(
    locator.locator.get<WindowManagerListeners>(),
  );

  runApp(
    LocatorProvider(
      locator: locator.locator,
      child: const App(),
    ),
  );
}
