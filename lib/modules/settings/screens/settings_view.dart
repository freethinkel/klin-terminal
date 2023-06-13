import 'package:cheber_terminal/core/widgets/controller_connector.dart';
import 'package:cheber_terminal/core/widgets/rx_builder.dart';
import 'package:cheber_terminal/modules/settings/components/settings_tab.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ControllerConnector<SettingsController>(
      builder: (context, settingsController) => Column(
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
      ),
    );
  }
}
