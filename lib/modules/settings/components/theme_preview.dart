import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/modules/theme/models/theme.dart';
import 'package:klin/shared/components/icon/icon.dart';
import 'package:klin/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

class ThemePreview extends StatefulWidget {
  const ThemePreview({
    required this.theme,
    this.isActive = false,
    this.onSelect,
    super.key,
  });
  final Function()? onSelect;
  final KlinAppTheme theme;
  final bool isActive;

  @override
  State<ThemePreview> createState() => _ThemePreviewState();
}

class _ThemePreviewState extends State<ThemePreview> {
  var isHover = false;

  Widget _buildLine(Color? color, [double? width]) {
    return Container(
      width: width ?? 40,
      height: 6,
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildPreview() {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              _buildLine(widget.theme.terminalTheme.black, 80),
              _buildLine(widget.theme.terminalTheme.white, 30),
              _buildLine(widget.theme.terminalTheme.red, 25),
              const SizedBox(width: 10),
              _buildLine(widget.theme.terminalTheme.green, 10),
              _buildLine(widget.theme.terminalTheme.yellow, 70),
              const SizedBox(width: 20),
              const SizedBox(width: 10),
              _buildLine(widget.theme.terminalTheme.blue, 50),
              _buildLine(widget.theme.terminalTheme.magenta, 80),
              _buildLine(widget.theme.terminalTheme.cyan, 20),
              _buildLine(widget.theme.terminalTheme.yellow, 40),
              _buildLine(widget.theme.terminalTheme.white, 20),
              _buildLine(widget.theme.terminalTheme.red, 25),
              _buildLine(widget.theme.terminalTheme.black, 10),
              const SizedBox(width: 10),
              _buildLine(widget.theme.terminalTheme.cyan, 46),
              _buildLine(widget.theme.terminalTheme.blue, 20),
              _buildLine(widget.theme.terminalTheme.green, 40),
            ],
          ),
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
      child: Stack(
        children: [
          Positioned(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
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
              ),
            ),
          ),
          if (widget.isActive)
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppTheme.of(context).terminalTheme.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  TablerIcons.check,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
