import 'package:klin/modules/settings/components/input_control.dart';
import 'package:klin/modules/settings/components/input_control_number.dart';
import 'package:klin/modules/settings/components/scope_card.dart';
import 'package:klin/modules/settings/components/select_control.dart';
import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/components/slider_control.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/settings/models/settings.dart';
import 'package:klin/shared/components/input/controlled_input.dart';
import 'package:klin/shared/components/select/select.dart';
import 'package:klin/shared/components/slider/rx_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rx_flow/rx_flow.dart';

class GeneralSettingsView extends RxConsumer {
  const GeneralSettingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final settingsController = watcher.controller<SettingsController>();

    final fontFamily = watcher.watch(settingsController.fontFamily$) ?? "";
    final fontSize =
        (watcher.watch(settingsController.fontSize$) ?? 13.0).toDouble();
    final lineHeight = watcher.watch(settingsController.lineHeight$) ?? 1.0;
    final padding = watcher.watch(settingsController.padding$) ?? 0;
    final opacity = watcher.watch(
          settingsController.opacity$,
        ) ??
        1.0;

    final workingDirectory =
        watcher.watch(settingsController.workingDirectory$);
    final customWorkingDirectory =
        watcher.watch(settingsController.customWorkginDirectoryPath$) ?? "";

    return SettingsPage(
      children: [
        ScopeCard(
          title: "Text",
          children: [
            InputControlText(
              title: "Font family",
              value: fontFamily,
              placeholder: "Enter font family",
              onChanged: (value) {
                settingsController.fontFamily$.next(value);
              },
            ),
            InputControlNumber(
              title: "Font size",
              value: fontSize,
              max: 20,
              min: 1,
              step: 1,
              onChanged: (value) {
                settingsController.fontSize$.next(value.toInt());
              },
            ),
            InputControlNumber(
              title: "Line height",
              min: 0.1,
              step: 0.1,
              max: 5,
              value: lineHeight,
              onChanged: (value) {
                settingsController.lineHeight$.next(value);
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        ScopeCard(
          title: "Background",
          children: [
            SliderControl(
              title: "Opacity",
              value: opacity,
              onChanged: (value) {
                settingsController.opacity$.next(value);
              },
              showValue: (opacity * 100).ceil().toString(),
            ),
            InputControlNumber(
              title: "Padding",
              min: 0,
              step: 1,
              max: 100,
              value: padding.toDouble(),
              onChanged: (value) {
                settingsController.padding$.next(value.toInt());
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        ScopeCard(
          title: "Session",
          children: [
            SelectControl<WorkingDirectory>(
              title: "Working directory",
              value: workingDirectory,
              onChanged: (value) {
                settingsController.workingDirectory$.next(value);
              },
              items: WorkingDirectory.values
                  .map((value) =>
                      SelectItem(value: value, child: Text(value.label)))
                  .toList(),
            ),
            if (workingDirectory == WorkingDirectory.custom)
              InputControlText(
                title: "Custom working directory path",
                value: customWorkingDirectory,
                onChanged: (value) {
                  settingsController.customWorkginDirectoryPath$.next(value);
                },
              )
          ],
        ),
      ],
    );
  }
}
