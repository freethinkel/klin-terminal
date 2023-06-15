import 'package:cheber_terminal/core/widgets/rx_consumer.dart';
import 'package:cheber_terminal/modules/channel/controllers/channel.controller.dart';
import 'package:cheber_terminal/modules/mappings/models/intents.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:cheber_terminal/modules/tabs/controllers/tabs.controller.dart';
import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/shared/components/draggable_window/draggable_window.dart';
import 'package:cheber_terminal/modules/tabs/components/add_new_tab.dart';
import 'package:cheber_terminal/modules/tabs/components/tab_item.dart';
import 'package:flutter/cupertino.dart';

class CheberTabBar extends RxConsumer {
  const CheberTabBar({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final tabsController = watcher.controller<TabsController>();
    final channelController = watcher.controller<ChannelController>();
    final settingsController = watcher.controller<SettingsController>();

    final isFullscreen = watcher.watch(channelController.fullscreened$);
    final opacity = watcher.watch(settingsController.opacity$);
    final tabs = watcher.watch(tabsController.tabs$) ?? [];
    final currentTab = watcher.watch(tabsController.currentTab$);
    final tabIndex = tabs.indexOf(currentTab!);

    final bgColor = AppTheme.of(context).primary.withOpacity(opacity ?? 1);

    return Actions(
      actions: {
        NewTabMappingAction: CallbackAction(onInvoke: (_) {
          tabsController.addNewTab();
          return null;
        }),
        CloseTabMappingAction: CallbackAction(onInvoke: (_) {
          tabsController.closeTab(tabsController.currentTab$.value!);
          return null;
        }),
        NextTabMappingAction: CallbackAction(onInvoke: (_) {
          tabsController.nextTab();
          return null;
        }),
        PrevTabMappingAction: CallbackAction(onInvoke: (_) {
          tabsController.prevTab();
          return null;
        }),
        SetTabMappingAction:
            CallbackAction<SetTabMappingAction>(onInvoke: (intent) {
          if (tabsController.tabs$.value!.length > (intent.index - 1)) {
            tabsController.switchToTab(intent.index - 1);
          }
          return null;
        }),
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(offset: Offset.zero, color: bgColor)],
              border: Border(
                bottom: BorderSide(
                    color: AppTheme.of(context).selection.withOpacity(0.12)),
              ),
            ),
            child: Row(
              children: [
                DraggableWindow(
                  child: Row(
                    children: [
                      Container(
                        height: 38,
                        width: isFullscreen == true ? 0 : 70,
                        decoration: BoxDecoration(
                          color: bgColor,
                        ),
                      ),
                      Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: bgColor,
                        ),
                        alignment: Alignment.center,
                        width: 40,
                        child: Text(
                          "⌘ ${(tabIndex + 1)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: DefaultTextStyle.of(context)
                                .style
                                .color
                                ?.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
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
                                    child: CheberTab(
                                      isAllowClose: tabs.length > 1,
                                      isActive:
                                          currentTab == tab && tabs.length > 1,
                                      child: tab.title.isEmpty
                                          ? const CupertinoActivityIndicator(
                                              radius: 8,
                                            )
                                          : Text(
                                              tab.title,
                                              softWrap: false,
                                            ),
                                      onTap: () =>
                                          tabsController.currentTab$.next(tab),
                                      onClose: () =>
                                          tabsController.closeTab(tab),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        DraggableWindow(
                          ignoreDoubleTap: true,
                          child: AddNewTabButton(
                            onTap: () => tabsController.addNewTab(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: tabs
                  .map((tab) => Offstage(
                        offstage: currentTab != tab,
                        child: tab.child,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
