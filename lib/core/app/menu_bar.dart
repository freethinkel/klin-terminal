import 'package:cheber_terminal/modules/settings/screens/settings_view.dart';
import 'package:cheber_terminal/shared/components/modal/modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          label: "Cheber Terminal",
          menus: [
            PlatformMenuItem(
                label: "Settings",
                onSelected: () async {
                  openModa(context, const SettingsView());
                }),
            const PlatformMenuItem(label: "About"),
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.quit,
            )
          ],
        ),
      ],
      child: child,
    );
  }
}
