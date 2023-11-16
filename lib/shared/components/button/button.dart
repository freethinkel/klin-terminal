import 'package:flutter/material.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

class KlinButton extends StatefulWidget {
  const KlinButton({
    required this.child,
    this.onTap,
    super.key,
  });
  final Widget child;
  final Function()? onTap;

  @override
  State<KlinButton> createState() => _KlinButtonState();
}

class _KlinButtonState extends State<KlinButton> {
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
