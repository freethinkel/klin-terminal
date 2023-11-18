import 'package:klin/modules/settings/components/image_picker.dart';
import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/components/theme_preview.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:rx_flow/rx_flow.dart';

class ThemesSettingsView extends RxConsumer {
  const ThemesSettingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final themeController = watcher.controller<ThemeController>();
    final themes = watcher.watch(themeController.themes$) ?? [];
    final currentTheme = watcher.watch(themeController.theme$);
    final backgroundImage = watcher.watch(themeController.backgroundImage$);

    return SettingsPage(
      title: "Themes",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
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
          ),
          const SizedBox(
            height: 20,
          ),
          ImagePicker(
            label: "Background Image",
            image: backgroundImage,
            onSelect: (file) {
              themeController.setBackgroundImage(file);
            },
          ),
        ],
      ),
    );
  }
}
