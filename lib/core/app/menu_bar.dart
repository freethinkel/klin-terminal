import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/mappings/models/intents.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_flow/rx_flow.dart';

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
        PlatformMenu(
          label: "View",
          menus: [
            PlatformMenuItem(
              label: "Reset zoom level",
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.digit0, meta: true),
              onSelected: () {
                settingsController.zoomLevel$.next(1.0);
              },
            ),
            PlatformMenuItem(
              label: "Zoom in",
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.equal, meta: true),
              onSelected: () {
                settingsController.zoomLevel$.next(
                    (settingsController.zoomLevel$.value! + 0.1).clamp(0.1, 5));
              },
            ),
            PlatformMenuItem(
              label: "Zoom out",
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.minus, meta: true),
              onSelected: () {
                settingsController.zoomLevel$.next(
                    (settingsController.zoomLevel$.value! - 0.1).clamp(0.1, 5));
              },
            ),
          ],
        )
      ],
      child: child,
    );
  }
}
