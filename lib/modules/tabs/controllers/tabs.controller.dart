import 'package:cheber_terminal/core/models/controller.dart';
import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/modules/tabs/models/tab.dart';
import 'package:cheber_terminal/modules/terminal/screens/terminal_view.dart';
import 'package:flutter/material.dart';

class TabsController extends IController {
  late final tabs$ = RxState<List<TabNode>>(
    [
      _createNewTab(),
    ],
  );
  late final currentTab$ = RxState(tabs$.value!.first);

  TabNode _createNewTab() {
    final tabNode = TabNode(title: "", child: Container());
    final view = CheberTerminalView(
      onChangeTitle: (title) {
        tabNode.title = title;
        tabs$.next(tabs$.value!);
      },
    );
    tabNode.child = view;

    return tabNode;
  }

  void addNewTab() {
    tabs$.next([...tabs$.value ?? [], _createNewTab()]);
  }

  void closeTab(TabNode tab) {
    tabs$.next(tabs$.value!..remove(tab));
  }
}
