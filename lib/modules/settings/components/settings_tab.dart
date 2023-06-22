import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/shared/components/draggable_window/draggable_window.dart';
import 'package:cheber_terminal/shared/components/icon/icon.dart';
import 'package:cheber_terminal/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

class SettingsTabs extends StatefulWidget {
  const SettingsTabs({
    this.tabs = const [],
    super.key,
  });
  final List<SettingsTabButton> tabs;

  @override
  State<SettingsTabs> createState() => _SettingsTabsState();
}

class _SettingsTabsState extends State<SettingsTabs> {
  @override
  Widget build(BuildContext context) {
    return DraggableWindow(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.white.withOpacity(0.12))),
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 80),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.tabs
                    .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: item))
                    .toList(),
              ),
            ),
            Container(
              width: 80,
              alignment: Alignment.topRight,
              child: CloseBtn(
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CloseBtn extends StatefulWidget {
  const CloseBtn({
    this.onTap,
    super.key,
  });
  final Function()? onTap;

  @override
  State<CloseBtn> createState() => _CloseBtnState();
}

class _CloseBtnState extends State<CloseBtn> {
  var isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {},
      child: Tappable(
          onHover: (state) => setState(() => isHover = state),
          onTap: widget.onTap,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isHover ? 0.12 : 0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const CheberIcon(TablerIcons.x, size: 18),
          )),
    );
  }
}

class SettingsTabButton extends StatefulWidget {
  const SettingsTabButton({
    required this.text,
    required this.icon,
    this.isActive = false,
    this.onTap,
    super.key,
  });
  final String text;
  final IconData icon;
  final bool isActive;
  final Function()? onTap;

  @override
  State<SettingsTabButton> createState() => _SettingsTabButtonState();
}

class _SettingsTabButtonState extends State<SettingsTabButton> {
  var isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {},
      child: Tappable(
          onTap: widget.onTap,
          onHover: (state) => setState(() => isHover = state),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: AppTheme.of(context)
                  .selection
                  .withOpacity(isHover || widget.isActive ? 0.12 : 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                CheberIcon(widget.icon, size: 24),
                const SizedBox(height: 2),
                Text(
                  widget.text,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )),
    );
  }
}
