import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/modules/theme/models/theme.dart';
import 'package:cheber_terminal/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

class ThemePreview extends StatefulWidget {
  const ThemePreview({
    required this.theme,
    this.isActive = false,
    this.onSelect,
    super.key,
  });
  final Function()? onSelect;
  final CheberAppTheme theme;
  final bool isActive;

  @override
  State<ThemePreview> createState() => _ThemePreviewState();
}

class _ThemePreviewState extends State<ThemePreview> {
  var isHover = false;

  Widget _buildLine(Color? color, [double? width]) {
    return Container(
      width: width ?? 40,
      height: 10,
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildPreview() {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        _buildLine(
          widget.theme.terminalTheme.black,
        ),
        _buildLine(
          widget.theme.terminalTheme.white,
        ),
        _buildLine(
          widget.theme.terminalTheme.red,
        ),
        _buildLine(
          widget.theme.terminalTheme.green,
        ),
        _buildLine(
          widget.theme.terminalTheme.yellow,
        ),
        _buildLine(
          widget.theme.terminalTheme.blue,
        ),
        _buildLine(
          widget.theme.terminalTheme.magenta,
        ),
        _buildLine(
          widget.theme.terminalTheme.cyan,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = widget.theme;

    return Tappable(
      onTap: widget.onSelect,
      onHover: (state) => setState(() => isHover = state),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          constraints: const BoxConstraints(minWidth: 150, maxWidth: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.terminalTheme.background,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: AppTheme.of(context)
                      .selection
                      .withOpacity(widget.isActive ? 0.24 : 0),
                  spreadRadius: 4),
            ],
            border: Border.all(
              width: 2,
              color: (widget.isActive
                      ? AppTheme.of(context).selection
                      : theme.selection)
                  .withOpacity(isHover || widget.isActive ? 1 : 0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: _buildPreview(),
              ),
              Opacity(
                opacity: widget.isActive ? 1 : 0.7,
                child: Text(
                  theme.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
