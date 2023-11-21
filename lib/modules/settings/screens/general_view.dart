import 'package:klin/modules/settings/components/input_control.dart';
import 'package:klin/modules/settings/components/input_control_number.dart';
import 'package:klin/modules/settings/components/scope_card.dart';
import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/components/slider_control.dart';
import 'package:klin/modules/settings/components/switch_control.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/shared/components/input/controlled_input.dart';
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
      ],
    );

    return SettingsPage(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Wrap(
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.end,
              alignment: WrapAlignment.start,
              runSpacing: 10,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 240),
                  child: ControlledKlinInput(
                    value: fontFamily,
                    label: "Font family",
                    placeholder: "Enter font family",
                    onInput: (value) =>
                        settingsController.fontFamily$.next(value),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: ControlledKlinInput(
                    value: fontSize.toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]*'))
                    ],
                    onInput: (value) => settingsController.fontSize$.next(
                        int.tryParse(value) ??
                            settingsController.fontSize$.value ??
                            13),
                    label: "Font size",
                    placeholder: "Enter font size",
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: ControlledKlinInput(
                    value: lineHeight.toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]*.[0-9]*'))
                    ],
                    onInput: (value) => settingsController.lineHeight$
                        .next(double.tryParse(value) ?? 1),
                    label: "Line height",
                    placeholder: "Enter line height",
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: ControlledKlinInput(
                    value: padding.toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]*'))
                    ],
                    onInput: (value) => settingsController.padding$
                        .next(int.tryParse(value) ?? 0),
                    label: "Padding",
                    placeholder: "Enter terminal inner padding",
                  ),
                ),
              ]),
        ),
        FractionallySizedBox(
          widthFactor: 0.5,
          child: RxSlider(
            label: "Opacity",
            state: settingsController.opacity$,
          ),
        )
      ]
          .map((child) => Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: child,
              ))
          .toList(),
    );
  }
}
