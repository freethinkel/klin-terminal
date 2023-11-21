import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.children,
    super.key,
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Column(
            children: children
                .map(
                  (item) => FractionallySizedBox(widthFactor: 1, child: item),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
