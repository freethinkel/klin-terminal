import 'package:cheber_terminal/modules/tabs/screens/tab_bar.dart';
import 'package:flutter/material.dart';

class CheberTerminalAppView extends StatefulWidget {
  const CheberTerminalAppView({super.key});

  @override
  State<CheberTerminalAppView> createState() => _CheberTerminalAppViewState();
}

class _CheberTerminalAppViewState extends State<CheberTerminalAppView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: FractionallySizedBox(
        widthFactor: 1,
        child: CheberTabBar(),
      ),
    );
  }
}
