import 'dart:io';

import 'package:cheber_terminal/core/models/controller.dart';
import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/modules/tabs/models/tab.dart';
import 'package:cheber_terminal/modules/terminal/screens/terminal_view.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xterm/ui.dart';

class TabsController extends IController {
  late final tabs$ = RxState<List<TabNode>>(
    [
      _createNewTab(),
    ],
  );
  late final currentTab$ = RxState(tabs$.value!.first)
    ..stream.listen((tabNode) {
      (tabNode.child as CheberTerminalView).focusNode?.requestFocus();
    });

  TabNode _createNewTab() {
    final tabNode = TabNode(
      title: "",
      child: Container(),
      uuid: const Uuid().v4(),
    );
    final focusNode = FocusNode();
    final view = CheberTerminalView(
      key: Key(tabNode.uuid),
      onChangeTitle: (title) {
        tabNode.title = title;
        tabs$.next(tabs$.value!);
      },
      onExit: () {
        closeTab(tabNode);
      },
      focusNode: focusNode,
    );
    tabNode.child = view;

    return tabNode;
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
