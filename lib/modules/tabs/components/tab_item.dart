import 'package:oshmes_terminal/modules/theme/components/theme_connector.dart';
import 'package:oshmes_terminal/shared/components/icon/icon.dart';
import 'package:oshmes_terminal/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

class OshmesTab extends StatefulWidget {
  const OshmesTab({
    required this.child,
    this.isActive = false,
    this.isAllowClose = true,
    this.onTap,
    this.onClose,
    this.focusNode,
    super.key,
  });
  final bool isActive;
  final bool isAllowClose;
  final Widget child;
  final Function()? onTap;
  final Function()? onClose;
  final FocusNode? focusNode;

  @override
  State<OshmesTab> createState() => _OshmesTabState();
}

class _OshmesTabState extends State<OshmesTab> {
  var isHover = false;
  var isHoverAddBtn = false;

  Widget _buildText(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            color: DefaultTextStyle.of(context).style.color?.withOpacity(
                isHover || widget.isActive || !widget.isAllowClose ? 1 : 0.8),
          ),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var bgColor = AppTheme.of(context).selection.withOpacity(
          (isHover || widget.isActive) && widget.isAllowClose ? 0.12 : 0,
        );
    var closeBtnBgColor = AppTheme.of(context).selection.withOpacity(
          isHoverAddBtn ? 0.5 : 0,
        );

    return FractionallySizedBox(
      heightFactor: 1,
      child: Focus(
        focusNode: widget.focusNode,
        child: Tappable(
          onTap: widget.onTap,
          onHover: (state) => setState(() => isHover = state),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: _buildText(context),
                  ),
                ),
                if (widget.isAllowClose)
                  Tappable(
                    onTap: widget.onClose,
                    onHover: (state) => setState(() => isHoverAddBtn = state),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      opacity: isHover || widget.isActive ? 1 : 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: closeBtnBgColor,
                        ),
                        child: const OshmesIcon(
                          TablerIcons.x,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
