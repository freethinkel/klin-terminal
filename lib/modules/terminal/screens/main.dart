import 'package:klin/modules/tabs/screens/tab_bar.dart';
import 'package:flutter/material.dart';

class KlinTerminalAppView extends StatefulWidget {
  const KlinTerminalAppView({super.key});

  @override
  State<KlinTerminalAppView> createState() => _KlinTerminalAppViewState();
}

class _KlinTerminalAppViewState extends State<KlinTerminalAppView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FractionallySizedBox(
        widthFactor: 1,
        child: KlinTabBar(),
      ),
    );
  }
}
