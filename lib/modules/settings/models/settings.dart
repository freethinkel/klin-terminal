import 'package:flutter/widgets.dart';

class SettingsTab {
  SettingsTab({
    required this.title,
    required this.icon,
    this.view,
  });
  String title;
  IconData icon;
  Widget? view;
}

enum WorkingDirectory {
  home(label: "Home directory", key: "home"),
  previousTerminal(
      label: "Reuse previous session's directory", key: "reuse_previous"),
  custom(label: "Custom directory", key: "custom");

  const WorkingDirectory({
    required this.label,
    required this.key,
  });
  final String label;
  final String key;

  @override
  toString() {
    return key;
  }
}
