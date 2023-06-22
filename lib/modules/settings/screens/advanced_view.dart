import 'package:cheber_terminal/core/widgets/rx_consumer.dart';
import 'package:cheber_terminal/modules/settings/components/settings_page.dart';
import 'package:cheber_terminal/modules/settings/controllers/settings.controller.dart';
import 'package:cheber_terminal/shared/components/checkbox/checkbox.dart';
import 'package:cheber_terminal/shared/components/input/rx_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdvancedSettingsView extends RxConsumer {
  const AdvancedSettingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final settingsController = watcher.controller<SettingsController>();

    final enableCustomGlyphs =
        watcher.watch(settingsController.enableCustomGlyphs$) == true;

    return SettingsPage(
      title: 'Advanced',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: RxInput(
              label: "Vertical line offset",
              placeholder: "Enter custom vertical line offset",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]*.[0-9]*'))
              ],
              valueMap: (value) =>
                  double.tryParse(value) ??
                  settingsController.customVerticalLineOffset$.value,
              state: settingsController.customVerticalLineOffset$,
            ),
          ),
          CheberCheckBox(
            description: "Enabled custom glyphs render",
            checked: enableCustomGlyphs,
            onChanged: (checked) {
              settingsController.enableCustomGlyphs$.next(checked);
            },
          ),
        ],
      ),
    );
  }
}
