import 'package:cheber_terminal/core/widgets/controller_connector.dart';
import 'package:cheber_terminal/core/widgets/rx_builder.dart';
import 'package:cheber_terminal/modules/settings/components/settings_page.dart';
import 'package:cheber_terminal/modules/settings/components/theme_preview.dart';
import 'package:cheber_terminal/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';

class ThemesSettingsView extends StatefulWidget {
  const ThemesSettingsView({super.key});

  @override
  State<ThemesSettingsView> createState() => _ThemesSettingsViewState();
}

class _ThemesSettingsViewState extends State<ThemesSettingsView> {
  @override
  Widget build(BuildContext context) {
    return ControllerConnector<ThemeController>(
        builder: (context, themeController) {
      return SettingsPage(
        title: "Themes",
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 1,
              child: SingleChildScrollView(
                  child: RxStateBuilder(
                      state: themeController.theme$,
                      builder: (context, currentTheme) {
                        return RxStateBuilder(
                            state: themeController.themes$,
                            builder: (context, themes) {
                              return Row(
                                children: themes!
                                    .map(
                                      (theme) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: ThemePreview(
                                          theme: theme,
                                          isActive: theme == currentTheme,
                                          onSelect: () => themeController.theme$
                                              .next(theme),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            });
                      })),
            )
          ],
        ),
      );
    });
  }
}
