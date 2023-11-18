import 'package:klin/modules/channel/services/channel.service.dart';
import 'package:klin/modules/mappings/services/shortcuts.service.dart';
import 'package:rx_flow/rx_flow.dart';

void setup(Locator locator) {
  locator
    ..register(ChannelService())
    ..register(
      ShortcutsService(),
    );
}
