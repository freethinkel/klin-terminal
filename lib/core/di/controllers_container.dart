import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:klin/shared/controller/window_manager.controller.dart';
import 'package:rx_flow/rx_flow.dart';

void setup(Locator locator) {
  locator
    ..register(ThemeController())
    ..register(
      WindowManagerController(
        shortcutsService: locator.get(),
        channelService: locator.get(),
      ),
    )
    ..register(
      SettingsController(
        windowManagerController: locator.get(),
      ),
    )
    ..register(
      TabsController(
        settingsController: locator.get(),
        windowManagerController: locator.get(),
      ),
    )
    ..register(
      MappingController(
        shortcutsService: locator.get(),
        tabsController: locator.get(),
        settingsController: locator.get(),
      ),
    );
}
