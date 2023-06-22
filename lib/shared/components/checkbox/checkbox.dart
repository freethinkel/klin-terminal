import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/shared/components/icon/icon.dart';
import 'package:cheber_terminal/shared/components/tappable/tappable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheberCheckBox extends StatefulWidget {
  const CheberCheckBox({
    required this.checked,
    this.onChanged,
    this.description,
    super.key,
  });
  final String? description;
  final bool checked;
  final Function(bool)? onChanged;

  @override
  State<CheberCheckBox> createState() => _CheberCheckBoxState();
}

class _CheberCheckBoxState extends State<CheberCheckBox> {
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
                    .withOpacity(widget.checked ? 1 : 0),
                border:
                    Border.all(color: AppTheme.of(context).selection, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: widget.checked
                  ? CheberIcon(
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
