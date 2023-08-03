import 'package:oshmes_terminal/modules/settings/screens/settings_view.dart';
import 'package:oshmes_terminal/shared/components/modal/modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: "Oshmes Terminal",
          menus: [
            PlatformMenuItem(
                label: "Settings",
                onSelected: () async {
                  openModa(context, const SettingsView());
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
