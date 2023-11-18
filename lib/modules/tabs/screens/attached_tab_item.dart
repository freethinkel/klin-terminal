import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klin/modules/tabs/components/tab_item.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:klin/modules/tabs/models/tab.dart';
import 'package:rx_flow/rx_flow.dart';

class AttachedTabItem extends RxConsumer {
  const AttachedTabItem({
    required this.tabs,
    required this.activeTab,
    required this.tab,
    super.key,
  });
  final List<TabNode> tabs;
  final TabNode? activeTab;
  final TabNode tab;

  @override
  Widget build(BuildContext context, watcher) {
    final tabsController = watcher.controller<TabsController>();

    final title = watcher.watch(tab.title) ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 4,
      ),
      child: KlinTab(
        isAllowClose: tabs.length > 1,
        isActive: activeTab == tab && tabs.length > 1,
        child: title.isEmpty
            ? const CupertinoActivityIndicator(
                radius: 8,
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                softWrap: false,
              ),
        onTap: () => tabsController.currentTab$.next(tab),
        onClose: () => tabsController.closeTab(tab),
      ),
    );
  }
}
