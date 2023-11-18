import 'package:klin/core/app/menu_bar.dart';
import 'package:klin/modules/mappings/screens/mappings_connector.dart';
import 'package:klin/modules/tabs/screens/tab_bar.dart';
import 'package:klin/modules/theme/components/background_connector.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:rx_flow/rx_flow.dart';

class App extends RxConsumer {
  const App({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ThemeConnector(
        child: MenuBar(
          child: MappingsConnector(
            child: BackgroundConnector(
              child: KlinTabBar(),
            ),
          ),
        ),
      ),
    );
  }
}
