import 'package:get_it/get_it.dart';
import 'package:klin/modules/mappings/services/shortcuts.service.dart';

void setup(GetIt locator) {
  locator.registerSingleton(
    ShortcutsService(),
  );
}
