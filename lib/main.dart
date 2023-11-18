import 'package:klin/core/app/app.dart';
import 'package:klin/modules/channel/services/channel.service.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:rx_flow/rx_flow.dart';

import 'core/di/locator.dart' as locator;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  locator.setup();

  locator.locator.get<ChannelService>().init();
  await locator.locator.get<ThemeController>().init();
  locator.locator.get<MappingController>().init();

  runApp(
    LocatorProvider(
      locator: locator.locator,
      child: const App(),
    ),
  );
}
