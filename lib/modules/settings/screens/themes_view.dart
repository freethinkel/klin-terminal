import 'package:klin/core/widgets/rx_consumer.dart';
import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/components/theme_preview.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';

class ThemesSettingsView extends RxConsumer {
  const ThemesSettingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final themeController = watcher.controller<ThemeController>();
    final themes = watcher.watch(themeController.themes$) ?? [];
    final currentTheme = watcher.watch(themeController.theme$);

    return SettingsPage(
      title: "Themes",
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: themes
                      .map(
                        (theme) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: ThemePreview(
                            theme: theme,
                            isActive: theme == currentTheme,
                            onSelect: () => themeController.setTheme(theme),
                          ),
                        ),
                      )
                      .toList(),
                )),
          )
        ],
      ),
    );
  }
}
