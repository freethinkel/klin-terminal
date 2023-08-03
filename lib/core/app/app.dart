import 'dart:io';

import 'package:oshmes_terminal/core/app/menu_bar.dart';
import 'package:oshmes_terminal/modules/mappings/screens/mappings_connector.dart';
import 'package:oshmes_terminal/modules/tabs/screens/tab_bar.dart';
import 'package:oshmes_terminal/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart' hide MenuBar;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const ThemeConnector(
      child: MenuBar(
        child: MappingsConnector(
          child: OshmesTabBar(),
        ),
      ),
    );
  }
}
