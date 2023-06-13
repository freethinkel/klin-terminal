import 'package:cheber_terminal/core/widgets/controller_connector.dart';
import 'package:cheber_terminal/core/widgets/rx_builder.dart';
import 'package:cheber_terminal/modules/channel/controllers/channel.controller.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:cheber_terminal/modules/tabs/controllers/tabs.controller.dart';
import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/shared/components/draggable_window/draggable_window.dart';
import 'package:cheber_terminal/modules/tabs/components/add_new_tab.dart';
import 'package:cheber_terminal/modules/tabs/components/tab_item.dart';
import 'package:flutter/material.dart';

class CheberTabBar extends StatefulWidget {
  const CheberTabBar({super.key});

  @override
  State<CheberTabBar> createState() => _CheberTabBarState();
}

class _CheberTabBarState extends State<CheberTabBar> {
  @override
  Widget build(BuildContext context) {
    return ControllerConnector<TabsController>(
      builder: (context, tabsController) => Column(
        children: [
          ControllerConnector<SettingsController>(
              builder: (context, settingsController) {
            return ControllerConnector<ChannelController>(
                builder: (context, controller) {
              return RxStateBuilder(
                  state: controller.fullscreened$,
                  builder: (context, isFullscreen) {
                    return RxStateBuilder(
                      state: settingsController.opacity$,
                      builder: (context, opacity) => Row(
                        children: [
                          DraggableWindow(
                            child: Container(
                              height: 38,
                              width: isFullscreen == true ? 0 : 100,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context)
                                    .primary
                                    .withOpacity(opacity ?? 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context)
                                    .primary
                                    .withOpacity(opacity ?? 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: RxStateBuilder(
                                        state: tabsController.currentTab$,
                                        builder: (context, currentTab) {
                                          return RxStateBuilder(
                                            state: tabsController.tabs$,
                                            builder: (context, tabs) => Row(
                                              children: tabs!
                                                  .map(
                                                    (tab) => Expanded(
                                                      child: CheberTab(
                                                        isActive:
                                                            currentTab == tab,
                                                        child: Text(tab.title),
                                                        onTap: () =>
                                                            tabsController
                                                                .currentTab$
                                                                .next(tab),
                                                        onClose: () =>
                                                            tabsController
                                                                .closeTab(tab),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          );
                                        }),
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
                    );
                  });
            });
          }),
          Expanded(
            child: RxStateBuilder(
                state: tabsController.tabs$,
                builder: (context, tabs) {
                  return RxStateBuilder(
                    state: tabsController.currentTab$,
                    builder: (context, currentTab) {
                      return Stack(
                        children: tabs!
                            .map((tab) => Offstage(
                                  offstage: currentTab != tab,
                                  child: tab.child,
                                ))
                            .toList(),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
