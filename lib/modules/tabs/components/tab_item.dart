import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:cheber_terminal/shared/components/icon/icon.dart';
import 'package:cheber_terminal/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

class CheberTab extends StatefulWidget {
  const CheberTab({
    required this.child,
    this.isActive = false,
    this.onTap,
    this.onClose,
    super.key,
  });
  final bool isActive;
  final Widget child;
  final Function()? onTap;
  final Function()? onClose;

  @override
  State<CheberTab> createState() => _CheberTabState();
}

class _CheberTabState extends State<CheberTab> {
  var isHover = false;
  var isHoverAddBtn = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Tappable(
        onTap: widget.onTap,
        onHover: (state) => setState(() => isHover = state),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.of(context)
                .selection
                .withOpacity(isHover || widget.isActive ? 0.12 : 0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: DefaultTextStyle.of(context)
                        .style
                        .color
                        ?.withOpacity(isHover || widget.isActive ? 1 : 0.8),
                  ),
                  child: widget.child,
                ),
              ),
              Tappable(
                onTap: widget.onClose,
                onHover: (state) => setState(() => isHoverAddBtn = state),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.of(context)
                        .selection
                        .withOpacity(isHoverAddBtn ? 0.5 : 0),
                  ),
                  child: const CheberIcon(
                    TablerIcons.x,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
