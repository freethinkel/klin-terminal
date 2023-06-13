import 'package:get_it/get_it.dart';
import 'services_container.dart' as services_container;
import 'controllers_container.dart' as controllers_container;

final locator = GetIt.asNewInstance();

void setup() {
  services_container.setup(locator);
  controllers_container.setup(locator);
}
