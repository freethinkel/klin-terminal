import 'package:oshmes_terminal/core/widgets/rx_builder.dart';
import 'package:oshmes_terminal/core/widgets/rx_consumer.dart';
import 'package:oshmes_terminal/modules/channel/controllers/channel.controller.dart';
import 'package:oshmes_terminal/modules/mappings/screens/mappings_connector.dart';
import 'package:oshmes_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:oshmes_terminal/modules/tabs/controllers/tabs.controller.dart';
import 'package:oshmes_terminal/modules/tabs/screens/view_tree.dart';
import 'package:oshmes_terminal/modules/terminal/models/terminal_node.dart';
import 'package:oshmes_terminal/modules/theme/components/theme_connector.dart';
import 'package:oshmes_terminal/shared/components/draggable_window/draggable_window.dart';
import 'package:oshmes_terminal/modules/tabs/components/add_new_tab.dart';
import 'package:oshmes_terminal/modules/tabs/components/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OshmesTabBar extends RxConsumer {
  const OshmesTabBar({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final tabsController = watcher.controller<TabsController>();
    final channelController = watcher.controller<ChannelController>();
    final settingsController = watcher.controller<SettingsController>();

    final isFullscreen = watcher.watch(channelController.fullscreened$);
    final opacity = watcher.watch(settingsController.opacity$);
    final tabs = watcher.watch(tabsController.tabs$) ?? [];
    final currentTab = watcher.watch(tabsController.currentTab$);

    final bgColor = AppTheme.of(context).primary.withOpacity(opacity ?? 1);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          DraggableWindow(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(offset: Offset.zero, color: bgColor)],
                // border: Border(
                //   bottom: BorderSide(
                //       color: AppTheme.of(context).selection.withOpacity(0.12)),
                // ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 38,
                    width: isFullscreen == true ? 0 : 78,
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: bgColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: tabs
                                  .map(
                                    (tab) => Expanded(
                                      child: RxStateBuilder(
                                        state: tab.title,
                                        builder: (context, title) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                            vertical: 4,
                                          ),
                                          child: OshmesTab(
                                            isAllowClose: tabs.length > 1,
                                            isActive: currentTab == tab &&
                                                tabs.length > 1,
                                            child: title!.isEmpty
                                                ? const CupertinoActivityIndicator(
                                                    radius: 8,
                                                  )
                                                : Text(
                                                    title,
                                                    textAlign: TextAlign.center,
                                                    softWrap: false,
                                                  ),
                                            onTap: () => tabsController
                                                .currentTab$
                                                .next(tab),
                                            onClose: () =>
                                                tabsController.closeTab(tab),
                                          ),
                                        ),
                                      ),
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
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: tabs
                  .map(
                    (tab) => Offstage(
                      offstage: currentTab != tab,
                      key: Key(tab.uuid),
                      child: TabViewTree(
                        key: Key(tab.uuid),
                        terminalNode: TerminalNode(),
                        tabNode: tab,
                        onClose: (node) {
                          tabsController.closeTab(tab);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
