import 'package:flutter/widgets.dart';

class Mapping {
  const Mapping({
    required this.key,
    required this.activator,
    required this.intent,
  });
  final Intent intent;
  final String key;
  final SingleActivator activator;
}
