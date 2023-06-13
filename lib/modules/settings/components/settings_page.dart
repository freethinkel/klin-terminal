import 'package:cheber_terminal/shared/components/title/title.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.child,
    required this.title,
    super.key,
  });
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheberTitle(
                title,
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
