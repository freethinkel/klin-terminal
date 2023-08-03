import 'package:oshmes_terminal/core/app/app.dart';
import 'package:oshmes_terminal/core/widgets/controller_connector.dart';
import 'package:oshmes_terminal/modules/channel/controllers/channel.controller.dart';
import 'package:oshmes_terminal/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';

import 'core/di/locator.dart' as locator;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  locator.setup();

  ControllerConnector.of<ChannelController>().init();
  await ControllerConnector.of<ThemeController>().init();

  runApp(const App());
}
