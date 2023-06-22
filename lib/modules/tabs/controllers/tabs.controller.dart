import 'dart:io';

import 'package:cheber_terminal/core/models/controller.dart';
import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/modules/tabs/models/tab.dart';

import 'package:uuid/uuid.dart';

class TabsController extends IController {
  late final tabs$ = RxState<List<TabNode>>([_createNewTab()]);
  late final currentTab$ = RxState(tabs$.value!.first)
    ..stream.listen((tab) {
      tab.lastFocusedNode?.focusNode.requestFocus();
    });

  TabNode _createNewTab() {
    return TabNode(uuid: const Uuid().v4());
  }

  void addNewTab() {
    var newTab = _createNewTab();
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
