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
