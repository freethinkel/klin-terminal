import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/shared/components/draggable_window/draggable_window.dart';
import 'package:cheber_terminal/shared/components/icon/icon.dart';
import 'package:cheber_terminal/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

class CheberTab extends StatefulWidget {
  const CheberTab({
    required this.child,
    this.isActive = false,
    this.isAllowClose = true,
    this.onTap,
    this.onClose,
    super.key,
  });
  final bool isActive;
  final bool isAllowClose;
  final Widget child;
  final Function()? onTap;
  final Function()? onClose;

  @override
  State<CheberTab> createState() => _CheberTabState();
}

class _CheberTabState extends State<CheberTab> {
  var isHover = false;
  var isHoverAddBtn = false;

  Widget _buildText() {
    return DefaultTextStyle(
      style: TextStyle(
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

    return DraggableWindow(
      disabled: widget.isAllowClose,
      child: FractionallySizedBox(
        heightFactor: 1,
        child: Tappable(
          onTap: widget.onTap,
          onHover: (state) => setState(() => isHover = state),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: _buildText(),
                  ),
                ),
                if (widget.isAllowClose)
                  Tappable(
                    onTap: widget.onClose,
                    onHover: (state) => setState(() => isHoverAddBtn = state),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      opacity: isHover ? 1 : 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: closeBtnBgColor,
                        ),
                        child: const CheberIcon(
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
