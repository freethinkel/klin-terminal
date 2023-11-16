import 'package:collection/collection.dart';
import 'package:klin/core/widgets/rx_consumer.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/mappings/models/intents.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuBar extends RxConsumer {
  const MenuBar({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context, watcher) {
    final mappingsController = watcher.controller<MappingController>();
    final settingsController = watcher.controller<SettingsController>();

    final mappings = watcher.watch(mappingsController.mappings) ?? [];
    final mapping = mappings.firstWhereOrNull(
        (item) => item.action == AppMappingActions.openSettings);

    settingsController.setContext(context);

    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: "Klin Terminal",
          menus: [
            PlatformMenuItem(
                label: "Settings",
                shortcut: mapping?.activator,
                onSelected: () {
                  settingsController.openSettings();
                }),
            const PlatformMenuItem(label: "About"),
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.quit,
            ),
          ],
        ),
        const PlatformMenu(
          label: "View",
          menus: [],
        )
      ],
      child: child,
    );
  }
}
