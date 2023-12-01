import 'package:klin/modules/settings/components/scope_card.dart';
import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/components/switch_control.dart';
import 'package:klin/modules/settings/components/theme_preview.dart';
import 'package:klin/modules/theme/controllers/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:klin/shared/components/image_picker/image_picker.dart';
import 'package:rx_flow/rx_flow.dart';

class ThemesSettingsView extends RxConsumer {
  const ThemesSettingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final themeController = watcher.controller<ThemeController>();
    final themes = watcher.watch(themeController.themes$) ?? [];
    final currentTheme = watcher.watch(themeController.theme$);
    final backgroundImage = watcher.watch(themeController.backgroundImage$);
    final glowEffectEnabled =
        watcher.watch(themeController.glowEffectEnabled$) == true;

    final width = MediaQuery.of(context).size.width;

    return SettingsPage(
      children: [
        ScopeCard(
          title: "",
          children: [
            SwitchControl(
              title: "Enable glow effect",
              value: glowEffectEnabled,
              onChanged: (value) {
                themeController.glowEffectEnabled$.next(value);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Themes",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: DefaultTextStyle.of(context).style.color?.withOpacity(0.8),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: Wrap(
            direction: Axis.horizontal,
            children: themes
                .map(
                  (theme) => FractionallySizedBox(
                    widthFactor: switch (width) {
                      < 350 => 1,
                      < 500 => 1 / 2,
                      _ => 1 / 3,
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ThemePreview(
                        theme: theme,
                        isActive: theme == currentTheme,
                        onSelect: () => themeController.setTheme(theme),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
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
    );
  }
}
