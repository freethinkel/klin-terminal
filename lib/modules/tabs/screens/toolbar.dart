import 'package:flutter/material.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/tabs/components/add_new_tab.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:klin/modules/tabs/screens/attached_tab_item.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/draggable_window/draggable_window.dart';
import 'package:klin/shared/controller/window_manager.controller.dart';
import 'package:rx_flow/rx_flow.dart';

class Toolbar extends RxConsumer {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final windowManagerController =
        watcher.controller<WindowManagerController>();
    final settingsController = watcher.controller<SettingsController>();
    final tabsController = watcher.controller<TabsController>();

    final isFullscreen =
        watcher.watch(windowManagerController.fullscreened$) == true;
    final isAutoHideToolbar =
        watcher.watch(settingsController.autoHideToolbar$) == true;

    final tabs = watcher.watch(tabsController.tabs$) ?? [];
    final currentTab = watcher.watch(tabsController.currentTab$);

    final opacity = watcher.watch(settingsController.opacity$);
    final bgColor = AppTheme.of(context).primary.withOpacity(opacity ?? 1);

    return DraggableWindow(
      child: Container(
        height: 38,
        color: bgColor,
        child: Row(
          children: [
            Container(
              width: isFullscreen || isAutoHideToolbar ? 2 : 78,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: tabs
                          .map(
                            (tab) => Expanded(
                              child: AttachedTabItem(
                                  tabs: tabs, activeTab: currentTab, tab: tab),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  AddNewTabButton(
                    onTap: () => tabsController.addNewTab(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
