import 'package:klin/modules/mappings/services/shortcuts.service.dart';
import 'package:rx_flow/rx_flow.dart';

void setup(Locator locator) {
  locator.register(
    ShortcutsService(),
  );
}
