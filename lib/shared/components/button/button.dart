import 'package:flutter/material.dart';
import 'package:oshmes_terminal/modules/theme/components/theme_connector.dart';
import 'package:oshmes_terminal/shared/components/tappable/tappable.dart';

class OshmesButton extends StatefulWidget {
  const OshmesButton({
    required this.child,
    this.onTap,
    super.key,
  });
  final Widget child;
  final Function()? onTap;

  @override
  State<OshmesButton> createState() => _OshmesButtonState();
}

class _OshmesButtonState extends State<OshmesButton> {
  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppTheme.of(context).selection.withOpacity(0.1),
          border: Border.all(
            color: AppTheme.of(context).selection.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: widget.child,
      ),
    );
  }
}
