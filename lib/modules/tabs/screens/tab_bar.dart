import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/core/widgets/controller_connector.dart';
import 'package:cheber_terminal/core/widgets/rx_builder.dart';
import 'package:cheber_terminal/modules/channel/controllers/channel.controller.dart';
import 'package:cheber_terminal/modules/mappings/models/intents.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:cheber_terminal/modules/tabs/controllers/tabs.controller.dart';
import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/shared/components/draggable_window/draggable_window.dart';
import 'package:cheber_terminal/modules/tabs/components/add_new_tab.dart';
import 'package:cheber_terminal/modules/tabs/components/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CheberTabBar extends StatefulWidget {
  const CheberTabBar({super.key});

  @override
  State<CheberTabBar> createState() => _CheberTabBarState();
}

class _CheberTabBarState extends State<CheberTabBar> {
  @override
  Widget build(BuildContext context) {
    return ControllerConnector<TabsController>(
      builder: (context, tabsController) => Actions(
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
                              child: Row(
                                children: [
                                  Container(
                                    height: 38,
                                    width: isFullscreen == true ? 0 : 70,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .primary
                                          .withOpacity(opacity ?? 1),
                                    ),
                                  ),
                                  Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .primary
                                          .withOpacity(opacity ?? 1),
                                    ),
                                    alignment: Alignment.center,
                                    width: 40,
                                    child: RxStateBuilder(
                                      state: RxState(0).addStream(
                                          Rx.combineLatest2(
                                              tabsController.currentTab$.stream,
                                              tabsController.tabs$.stream,
                                              (currentTab, tabs) =>
                                                  tabs.indexOf(currentTab))),
                                      builder: (context, index) => Text(
                                        "⌘ ${(index! + 1)}",
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
                                  ),
                                ],
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
                                                          isAllowClose:
                                                              tabs.length > 1,
                                                          isActive:
                                                              currentTab ==
                                                                      tab &&
                                                                  tabs.length >
                                                                      1,
                                                          child: tab
                                                                  .title.isEmpty
                                                              ? const CupertinoActivityIndicator(
                                                                  radius: 8,
                                                                )
                                                              : Text(
                                                                  tab.title,
                                                                  softWrap:
                                                                      false,
                                                                ),
                                                          onTap: () =>
                                                              tabsController
                                                                  .currentTab$
                                                                  .next(tab),
                                                          onClose: () =>
                                                              tabsController
                                                                  .closeTab(
                                                                      tab),
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
      ),
    );
  }
}
