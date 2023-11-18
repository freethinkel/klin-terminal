import 'package:rx_flow/rx_flow.dart';

import 'services_container.dart' as services_container;
import 'controllers_container.dart' as controllers_container;

final locator = Locator();

void setup() {
  services_container.setup(locator);
  controllers_container.setup(locator);
}
