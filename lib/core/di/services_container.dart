import 'package:get_it/get_it.dart';
import 'package:oshmes_terminal/modules/mappings/services/shortcuts.service.dart';

void setup(GetIt locator) {
  locator.registerSingleton(
    ShortcutsService(),
  );
}
