import 'package:flutter/material.dart';
import 'package:klin/modules/settings/models/settings.dart';
import 'package:klin/modules/settings/screens/advanced_view.dart';
import 'package:klin/modules/settings/screens/general_view.dart';
import 'package:klin/modules/settings/screens/mappings_view.dart';
import 'package:klin/modules/settings/screens/settings_view.dart';
import 'package:klin/modules/settings/screens/themes_view.dart';
import 'package:klin/shared/components/icon/icon.dart';
import 'package:klin/shared/components/modal/modal.dart';
import 'package:klin/shared/controller/window_manager.controller.dart';
import 'package:rx_flow/rx_flow.dart';

class SettingsController extends IController {
  SettingsController({required WindowManagerController windowManagerController})
      : _windowManagerController = windowManagerController {
    autoHideToolbar$.stream.listen((event) {
      if (event) {
        _windowManagerController.hideButtons();
      } else {
        _windowManagerController.showButtons();
      }
    });
  }
  final WindowManagerController _windowManagerController;

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
      view: const MappingsView(),
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
  final enableContextMenu$ = RxStateStorage(
    "enableContextMenu",
    mapper: (value) => value == "true",
    initialValue: true,
  );
  final cellBackgroundOpacity$ = RxStateStorage(
    "cellBackgroundOpacity",
    mapper: (value) => double.tryParse(value),
    initialValue: 1.0,
  );
  final transparentBackgroundCells$ = RxStateStorage(
    "transparentBackgroundCells",
    mapper: (value) => value == "true",
    initialValue: false,
  );
  final autoHideToolbar$ = RxStateStorage(
    "autohide_toolbar",
    mapper: (value) => value == "true",
    initialValue: false,
  );

  BuildContext? _context;
  setContext(BuildContext context) {
    _context = context;
  }

  BuildContext get context => _context!;
  bool _isSettingsOpen = false;

  Future<void> openSettings() async {
    if (_isSettingsOpen) {
      Navigator.of(context).maybePop();
      return;
    }

    _isSettingsOpen = true;
    await openModal(context, const SettingsView());
    _isSettingsOpen = false;
  }
}
