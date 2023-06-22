import 'package:cheber_terminal/core/widgets/rx_consumer.dart';
import 'package:cheber_terminal/modules/mappings/models/intents.dart';
import 'package:cheber_terminal/modules/tabs/controllers/tabs.controller.dart';
import 'package:flutter/material.dart';

class ActionsConnector extends RxConsumer {
  const ActionsConnector({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, watcher) {
    final tabsController = watcher.controller<TabsController>();

    return Actions(
      actions: ({
        NewTabMappingAction: (_) {
          tabsController.addNewTab();
        },
        CloseTabMappingAction: (_) {
          tabsController.closeTab(tabsController.currentTab$.value!);
        },
        NextTabMappingAction: (_) {
          tabsController.nextTab();
        },
        PrevTabMappingAction: (_) {
          tabsController.prevTab();
        },
        SetTabMappingAction: (SetTabMappingAction intent) {
          if (tabsController.tabs$.value!.length > (intent.index - 1)) {
            tabsController.switchToTab(intent.index - 1);
          }
        },
      }).map((key, dynamic value) =>
          MapEntry(key, CallbackAction(onInvoke: (intent) => value(intent)))),
      child: child,
    );
  }
}
