import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/shared/components/input/controlled_input.dart';
import 'package:klin/shared/components/input/rx_input.dart';
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
    final fontSize = watcher.watch(settingsController.fontSize$) ?? 13;
    final lineHeight = watcher.watch(settingsController.lineHeight$) ?? 1;
    final padding = watcher.watch(settingsController.padding$) ?? 0;

    return SettingsPage(
      title: "General",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        FilteringTextInputFormatter.allow(
                            RegExp('[0-9]*.[0-9]*'))
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
      ),
    );
  }
}
