import 'package:oshmes_terminal/modules/tabs/screens/tab_bar.dart';
import 'package:flutter/material.dart';

class OshmesTerminalAppView extends StatefulWidget {
  const OshmesTerminalAppView({super.key});

  @override
  State<OshmesTerminalAppView> createState() => _OshmesTerminalAppViewState();
}

class _OshmesTerminalAppViewState extends State<OshmesTerminalAppView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: FractionallySizedBox(
        widthFactor: 1,
        child: OshmesTabBar(),
      ),
    );
  }
}
