import 'package:oshmes_terminal/core/widgets/rx_builder.dart';
import 'package:oshmes_terminal/core/widgets/rx_consumer.dart';
import 'package:oshmes_terminal/modules/settings/components/settings_tab.dart';
import 'package:oshmes_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:flutter/material.dart';

class SettingsView extends RxConsumer {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final settingsController = watcher.controller<SettingsController>();

    return Column(
      children: [
        RxStateBuilder(
          state: settingsController.currentTab$,
          builder: (context, currentTab) => SettingsTabs(
            tabs: settingsController.tabs
                .map((tab) => SettingsTabButton(
                      text: tab.title,
                      icon: tab.icon,
                      isActive: currentTab == tab,
                      onTap: () => settingsController.currentTab$.next(tab),
                    ))
                .toList(),
          ),
        ),
        Expanded(
          child: RxStateBuilder(
            state: settingsController.currentTab$,
            builder: (context, tab) => Container(
              child: tab?.view,
            ),
          ),
        )
      ],
    );
  }
}
