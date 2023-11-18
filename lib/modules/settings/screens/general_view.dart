import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
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
                    child: RxInput(
                      state: settingsController.fontFamily$,
                      label: "Font family",
                      placeholder: "Enter font family",
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: RxInput(
                      state: settingsController.fontSize$,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]*'))
                      ],
                      valueMap: (value) =>
                          int.tryParse(value) ??
                          settingsController.fontSize$.value,
                      label: "Font size",
                      placeholder: "Enter font size",
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: RxInput(
                      state: settingsController.lineHeight$,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[0-9]*.[0-9]*'))
                      ],
                      valueMap: (value) =>
                          double.tryParse(value) ??
                          settingsController.lineHeight$.value,
                      label: "Line height",
                      placeholder: "Enter line height",
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: RxInput(
                      state: settingsController.padding$,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]*'))
                      ],
                      valueMap: (value) =>
                          int.tryParse(value) ??
                          settingsController.padding$.value,
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
