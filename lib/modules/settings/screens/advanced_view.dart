import 'package:klin/modules/settings/components/input_control_number.dart';
import 'package:klin/modules/settings/components/scope_card.dart';
import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/components/slider_control.dart';
import 'package:klin/modules/settings/components/switch_control.dart';
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
      // title: 'Advanced',
      children: [
        ScopeCard(
          title: "Cells modification",
          children: [
            SwitchControl(
                title: "Enable custom glyph render",
                value: enableCustomGlyphs,
                onChanged: (value) {
                  settingsController.enableCustomGlyphs$.next(value);
                }),
            InputControlNumber(
              title: "Vertical line offset",
              value: customVerticalLineOffset,
              min: -5,
              max: 5,
              step: 0.1,
              onChanged: (value) {
                settingsController.customVerticalLineOffset$.next(value);
              },
            ),
            SliderControl(
              value: cellBackgroundOpacity,
              title: "Cell background opacity",
              showValue: (cellBackgroundOpacity * 100).toInt().toString(),
              onChanged: (value) {
                settingsController.cellBackgroundOpacity$.next(value);
              },
            ),
            SwitchControl(
              title: "Transparent background cells",
              description:
                  "Transparent cell background if the theme background is the same as the cell background",
              value: transparentBackgroundCells,
              onChanged: (value) {
                settingsController.transparentBackgroundCells$.next(value);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        ScopeCard(
          title: "Other",
          children: [
            SwitchControl(
              title: "Autohide headerbar",
              value: autohideToolbar,
              onChanged: (value) {
                settingsController.autoHideToolbar$.next(value);
              },
            ),
            SwitchControl(
              title: "Enable context menu",
              value: enableContextMenu,
              onChanged: (value) {
                settingsController.enableContextMenu$.next(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
