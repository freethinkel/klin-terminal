import 'dart:async';

import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/tabs/components/tabbar_filers.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:klin/modules/tabs/models/constants.dart';
import 'package:klin/modules/tabs/screens/toolbar.dart';
import 'package:klin/modules/tabs/screens/view_tree.dart';
import 'package:klin/modules/terminal/models/terminal_node.dart';
import 'package:flutter/material.dart';
import 'package:klin/shared/components/tappable/tappable.dart';
import 'package:rx_flow/rx_flow.dart';

class KlinTabBar extends RxConsumer {
  KlinTabBar({super.key});

  final _isHover$ = RxState(false);

  @override
  Widget build(BuildContext context, watcher) {
    final tabsController = watcher.controller<TabsController>();
    final settingsController = watcher.controller<SettingsController>();

    final tabs = watcher.watch(tabsController.tabs$) ?? [];
    final currentTab = watcher.watch(tabsController.currentTab$);

    final isAutoHideToolbar =
        watcher.watch(settingsController.autoHideToolbar$) == true;

    final isHover = watcher.watch(_isHover$) == true;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: TOOLBAR_ANIMATION_DURATION,
            curve: TOOLBAR_ANIMATION_CURVE,
            top: isAutoHideToolbar ? 0 : TOOLBAR_HEIGHT,
            left: 0,
            right: 0,
            bottom: 0,
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
          ),
          if (isAutoHideToolbar)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Tappable(
                onHover: (state) => _isHover$.next(state),
                child: const SizedBox(
                  height: TOOLBAR_HEIGHT,
                ),
              ),
            ),
          AnimatedPositioned(
            duration: TOOLBAR_ANIMATION_DURATION,
            curve: TOOLBAR_ANIMATION_CURVE,
            top: isAutoHideToolbar && !isHover ? -TOOLBAR_HEIGHT : 0,
            left: 0,
            right: 0,
            child: TabbarFilers(
              isActive: isAutoHideToolbar,
              child: Tappable(
                onHover: (state) => _isHover$.next(state),
                child: const Toolbar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
