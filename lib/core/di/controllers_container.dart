import 'package:cheber_terminal/modules/channel/controllers/channel.controller.dart';
import 'package:cheber_terminal/modules/mappings/controllers/mappings.controller.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:cheber_terminal/modules/tabs/controllers/tabs.controller.dart';
import 'package:cheber_terminal/modules/theme/controllers/theme.controller.dart';
import 'package:get_it/get_it.dart';

void setup(GetIt locator) {
  locator
    ..registerSingleton(ChannelController())
    ..registerSingleton(ThemeController())
    ..registerSingleton(TabsController())
    ..registerSingleton(SettingsController())
    ..registerSingleton(MappingsController());
}
