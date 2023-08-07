import 'package:oshmes_terminal/core/models/controller.dart';
import 'package:oshmes_terminal/core/models/rx.dart';
import 'package:oshmes_terminal/core/models/rx_storage.dart';
import 'package:oshmes_terminal/modules/settings/models/settings.dart';
import 'package:oshmes_terminal/modules/settings/screens/advanced_view.dart';
import 'package:oshmes_terminal/modules/settings/screens/general_view.dart';
import 'package:oshmes_terminal/modules/settings/screens/mappings_view.dart';
import 'package:oshmes_terminal/modules/settings/screens/themes_view.dart';
import 'package:oshmes_terminal/shared/components/icon/icon.dart';

class SettingsController extends IController {
  final tabs = [
    SettingsTab(
      title: "General",
      icon: TablerIcons.settings,
      view: const GeneralSettingsView(),
    ),
    SettingsTab(
      title: "Theme",
      icon: TablerIcons.brush,
      view: const ThemesSettingsView(),
    ),
    SettingsTab(
      title: "Keymaps",
      icon: TablerIcons.keyboard,
      view: MappingsView(),
    ),
    SettingsTab(
      title: "Advanced",
      icon: TablerIcons.tools,
      view: const AdvancedSettingsView(),
    ),
  ];
  late final currentTab$ = RxState<SettingsTab>(tabs.first);

  final opacity$ = RxStateStorage<double>(
    "opacity",
    mapper: (value) => double.tryParse(value)?.clamp(0, 1),
    initialValue: 1.0,
  );
  final padding$ = RxStateStorage<int>(
    "terminalPadding",
    mapper: (value) => int.tryParse(value),
    initialValue: 0,
  );
  final fontFamily$ = RxStateStorage(
    "fontFamily",
    mapper: (value) => value,
    initialValue: "Menlo",
  );
  final fontSize$ = RxStateStorage(
    "fontSize",
    mapper: (value) => int.tryParse(value),
    initialValue: 14,
  );
  final lineHeight$ = RxStateStorage(
    "lineHeight",
    mapper: (value) => double.tryParse(value),
    initialValue: 1.4,
  );

  final customVerticalLineOffset$ = RxStateStorage(
    "customVerticalLineOffset",
    mapper: (value) => double.tryParse(value),
    initialValue: 0.0,
  );
  final enableCustomGlyphs$ = RxStateStorage(
    "enableCustomGlyphs",
    mapper: (value) => value == "true",
    initialValue: true,
  );
}
