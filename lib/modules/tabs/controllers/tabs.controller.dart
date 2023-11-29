import 'dart:io';

import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/settings/models/settings.dart';
import 'package:klin/modules/tabs/models/tab.dart';
import 'package:klin/modules/terminal/models/terminal_node.dart';
import 'package:klin/shared/controller/window_manager.controller.dart';
import 'package:rx_flow/rx_flow.dart';

import 'package:uuid/uuid.dart';

class TabsController extends IController {
  TabsController({
    required SettingsController settingsController,
    required WindowManagerController windowManagerController,
  })  : _settingsController = settingsController,
        _windowManagerController = windowManagerController;

  final SettingsController _settingsController;
  final WindowManagerController _windowManagerController;

  late final tabs$ = RxState<List<TabNode>>([]);
  late final currentTab$ = RxState<TabNode?>(null)
    ..stream.listen((tab) {
      tab?.lastFocusedNode?.focusNode.requestFocus();
    });

  @override
  init() async {
    final initialTab = await _createNewTab();
    tabs$.next([initialTab]);
    currentTab$.next(initialTab);
    _windowManagerController.focus$.stream.listen((hasFocus) {
      if (hasFocus) {
        currentTab$.value?.lastFocusedNode?.focusNode.requestFocus();
      }
    });
  }

  Future<String?> getWorkingDirectory() async {
    final cwd = switch (_settingsController.workingDirectory$.value!) {
      WorkingDirectory.home => Platform.environment["HOME"],
      WorkingDirectory.custom =>
        _settingsController.customWorkginDirectoryPath$.value,
      WorkingDirectory.previousTerminal =>
        await currentTab$.value?.lastFocusedNode?.getCwd()
    };

    return cwd;
  }

  Future<TabNode> _createNewTab() async {
    return TabNode(
      uuid: const Uuid().v4(),
      terminalNode: TerminalNode(
        initialWorkingDirectory: await getWorkingDirectory(),
      ),
    );
  }

  void addNewTab() async {
    var newTab = await _createNewTab();
    tabs$.next([...tabs$.value ?? [], newTab]);
    currentTab$.next(newTab);
  }

  void closeTab(TabNode tab) {
    if (tabs$.value!.length == 1) {
      exit(0);
    }
    var tabs = tabs$.value ?? [];
    if (currentTab$.value == tab) {
      var currentIndex = tabs.indexOf(tab);
      currentTab$.next(tabs[(currentIndex + 1) % tabs.length]);
    }
    tabs.remove(tab);
    tabs$.next(tabs);
  }

  void nextTab() {
    switchToTab(tabs$.value!.indexOf(currentTab$.value!) + 1);
  }

  void prevTab() {
    switchToTab(tabs$.value!.indexOf(currentTab$.value!) - 1);
  }

  void switchToTab(int index) {
    var tabs = tabs$.value ?? [];
    currentTab$.next(tabs[index % tabs.length]);
  }
}
