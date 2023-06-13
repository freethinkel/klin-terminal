import 'package:cheber_terminal/core/models/controller.dart';
import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/core/models/rx_storage.dart';
import 'package:cheber_terminal/modules/settings/models/settings.dart';
import 'package:cheber_terminal/modules/settings/screens/general_view.dart';
import 'package:cheber_terminal/modules/settings/screens/themes_view.dart';
import 'package:cheber_terminal/shared/components/icon/icon.dart';
import 'package:flutter/widgets.dart';

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
      view: Text("keymaps"),
    ),
    SettingsTab(
      title: "Advanced",
      icon: TablerIcons.tools,
      view: Text("advanced"),
    ),
  ];
  late final currentTab$ = RxState<SettingsTab>(tabs.first);

  final opacity$ = RxStateStorage<double>(
      "opacity", (value) => double.tryParse(value)?.clamp(0, 1), 1.0);

  final padding$ =
      RxStateStorage<int>("terminalPadding", (value) => int.tryParse(value), 0);
  final fontFamily$ = RxStateStorage("fontFamily", (value) => value, "Menlo");
  final fontSize$ =
      RxStateStorage("fontSize", (value) => int.tryParse(value), 14);
  final lineHeight$ =
      RxStateStorage("lineHeight", (value) => double.tryParse(value), 1.4);
}
