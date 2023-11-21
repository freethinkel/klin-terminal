import 'package:flutter/material.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

enum KlinButtonKind {
  raised,
  delete,
  clean,
}

enum KlinButtonSize {
  small,
  normal,
  large,
}

class KlinButton extends StatefulWidget {
  const KlinButton({
    required this.child,
    this.kind = KlinButtonKind.raised,
    this.size = KlinButtonSize.normal,
    this.onTap,
    super.key,
  });
  final Widget child;
  final KlinButtonKind kind;
  final KlinButtonSize size;
  final Function()? onTap;

  @override
  State<KlinButton> createState() => _KlinButtonState();
}

class _KlinButtonState extends State<KlinButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final color = switch (widget.kind) {
      KlinButtonKind.raised =>
        AppTheme.of(context).selection.withOpacity(isHover ? 0.2 : 0.1),
      KlinButtonKind.clean =>
        AppTheme.of(context).selection.withOpacity(isHover ? 0.2 : 0),
      KlinButtonKind.delete =>
        AppTheme.of(context).terminalTheme.red.withOpacity(0.8),
    };

    return Tappable(
      onTap: widget.onTap,
      onHover: (state) => setState(() => isHover = state),
      child: Container(
        padding: switch (widget.size) {
          KlinButtonSize.normal => const EdgeInsets.all(6),
          KlinButtonSize.small => const EdgeInsets.all(3),
          KlinButtonSize.large => const EdgeInsets.all(8),
        },
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
          ),
          borderRadius: BorderRadius.circular(
              widget.kind == KlinButtonKind.clean ? 0 : 6),
        ),
        child: widget.child,
      ),
    );
  }
}
