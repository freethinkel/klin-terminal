import 'package:oshmes_terminal/modules/theme/components/theme_connector.dart';
import 'package:oshmes_terminal/shared/components/icon/icon.dart';
import 'package:oshmes_terminal/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

class AddNewTabButton extends StatefulWidget {
  const AddNewTabButton({
    this.onTap,
    super.key,
  });
  final Function()? onTap;

  @override
  State<AddNewTabButton> createState() => _AddNewTabButtonState();
}

class _AddNewTabButtonState extends State<AddNewTabButton> {
  var isHover = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Container(
        padding: EdgeInsets.all(4),
        alignment: Alignment.center,
        child: Tappable(
          onTapUp: widget.onTap,
          onHover: (state) => setState(() => isHover = state),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: AppTheme.of(context)
                  .selection
                  .withOpacity(isHover ? 0.12 : 0),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(4),
            child: const OshmesIcon(TablerIcons.plus, size: 16),
          ),
        ),
      ),
    );
  }
}
