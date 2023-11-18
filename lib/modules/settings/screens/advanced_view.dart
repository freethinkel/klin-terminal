import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/shared/components/checkbox/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klin/shared/components/input/controlled_input.dart';
import 'package:klin/shared/components/slider/slider.dart';
import 'package:rx_flow/rx_flow.dart';

class AdvancedSettingsView extends RxConsumer {
  const AdvancedSettingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final settingsController = watcher.controller<SettingsController>();

    final enableCustomGlyphs =
        watcher.watch(settingsController.enableCustomGlyphs$) == true;
    final enableContextMenu =
        watcher.watch(settingsController.enableContextMenu$) == true;
    final cellBackgroundOpacity =
        watcher.watch(settingsController.cellBackgroundOpacity$) ?? 0;
    final transparentBackgroundCells =
        watcher.watch(settingsController.transparentBackgroundCells$) == true;
    final autohideToolbar =
        watcher.watch(settingsController.autoHideToolbar$) == true;

    final customVerticalLineOffset =
        watcher.watch(settingsController.customVerticalLineOffset$) ?? 0.0;

    return SettingsPage(
      title: 'Advanced',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: ControlledKlinInput(
              label: "Vertical line offset",
              placeholder: "Enter custom vertical line offset",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]*.[0-9]*'))
              ],
              onInput: (value) => settingsController.customVerticalLineOffset$
                  .next(double.tryParse(value) ?? 0.0),
              value: customVerticalLineOffset.toString(),
            ),
          ),
          KlinCheckBox(
            description: "Enabled custom glyphs render",
            checked: enableCustomGlyphs,
            onChanged: (checked) {
              settingsController.enableCustomGlyphs$.next(checked);
            },
          ),
          KlinCheckBox(
            description: "Enabled context menu",
            checked: enableContextMenu,
            onChanged: (checked) {
              settingsController.enableContextMenu$.next(checked);
            },
          ),
          const SizedBox(height: 12),
          KlinSlider(
            label: "Cells background opacity",
            value: cellBackgroundOpacity,
            onChanged: (value) {
              settingsController.cellBackgroundOpacity$.next(value);
            },
          ),
          KlinCheckBox(
            description: "Transparent background cells",
            checked: transparentBackgroundCells,
            onChanged: (checked) {
              settingsController.transparentBackgroundCells$.next(checked);
            },
          ),
          const SizedBox(height: 0),
          KlinCheckBox(
            description: "Autohide toolbar",
            checked: autohideToolbar,
            onChanged: (checked) {
              settingsController.autoHideToolbar$.next(checked);
            },
          )
        ],
      ),
    );
  }
}
