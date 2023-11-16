import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/icon/icon.dart';
import 'package:klin/shared/components/tappable/tappable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KlinCheckBox extends StatefulWidget {
  const KlinCheckBox({
    required this.checked,
    this.onChanged,
    this.description,
    super.key,
  });
  final String? description;
  final bool checked;
  final Function(bool)? onChanged;

  @override
  State<KlinCheckBox> createState() => _KlinCheckBoxState();
}

class _KlinCheckBoxState extends State<KlinCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: () {
        widget.onChanged?.call(!widget.checked);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppTheme.of(context)
                    .selection
                    .withOpacity(widget.checked ? 0.2 : 0),
                border: Border.all(
                    color: AppTheme.of(context).selection.withOpacity(0.3),
                    width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: widget.checked
                  ? KlinIcon(
                      TablerIcons.check,
                      size: 16,
                      color: DefaultTextStyle.of(context).style.color,
                    )
                  : null,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              widget.description ?? "",
              style: TextStyle(
                color:
                    DefaultTextStyle.of(context).style.color?.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
