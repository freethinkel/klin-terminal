import 'package:klin/modules/channel/controllers/channel.controller.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:klin/shared/controller/window_manager.controller.dart';
import 'package:rx_flow/rx_flow.dart';

void setup(Locator locator) {
  locator
    ..register(ChannelController())
    ..register(ThemeController())
    ..register(TabsController())
    ..register(SettingsController())
    ..register(
      MappingController(
        shortcutsService: locator.get(),
        tabsController: locator.get(),
        settingsController: locator.get(),
      ),
    )
    ..register(
      WindowManagerListeners(
        tabsController: locator.get(),
        shortcutsService: locator.get(),
      ),
    );
}
