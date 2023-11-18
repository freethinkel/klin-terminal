import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/icon/icon.dart';
import 'package:klin/shared/components/popover/popover.dart';
import 'package:klin/shared/components/tappable/tappable.dart';
import 'package:klin/shared/models/color.dart';

class Select<T> extends StatefulWidget {
  const Select({
    required this.items,
    this.placeholder,
    this.onSelect,
    this.value,
    this.width,
    super.key,
  });
  final List<SelectItem<T>> items;
  final String? placeholder;
  final Function(SelectItem<T>)? onSelect;
  final T? value;
  final double? width;

  @override
  State<Select<T>> createState() => _SelectState<T>();
}

class _SelectState<T> extends State<Select<T>> {
  bool isOpened = false;

  Widget _buildPlaceholder() {
    return DefaultTextStyle(
      style: TextStyle(
        color: DefaultTextStyle.of(context)
            .style
            .color
            ?.mix(AppTheme.of(context).primary, 0.4),
      ),
      child: Text(widget.placeholder ?? ""),
    );
  }

  Widget _buildValue() {
    return widget.items
            .firstWhereOrNull((element) => widget.value == element.value)
            ?.child ??
        Container();
  }

  @override
  Widget build(BuildContext context) {
    return Popover(
      onOpen: (state) => setState(() => isOpened = state),
      head: IntrinsicWidth(
        stepWidth: 0,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: AppTheme.of(context).selection.withOpacity(0.1)),
              color: AppTheme.of(context)
                  .primary
                  .mix(AppTheme.of(context).selection, 0.05),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: widget.value != null
                      ? _buildValue()
                      : _buildPlaceholder(),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: isOpened ? 0.5 : 0,
                  duration: const Duration(milliseconds: 140),
                  child: const KlinIcon(TablerIcons.chevronDown, size: 16),
                ),
              ],
            )),
      ),
      width: widget.width,
      popover: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: AppTheme.of(context)
              .primary
              .mix(AppTheme.of(context).selection, 0.05),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: AppTheme.of(context).selection.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.of(context).selection.withOpacity(0.03),
              offset: const Offset(0, 3),
              blurRadius: 5,
            ),
            BoxShadow(
              color: AppTheme.of(context).selection.withOpacity(0.03),
              offset: const Offset(0, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.items
                .map((item) => FractionallySizedBox(
                    widthFactor: 1,
                    child: _SelectItemWidget(
                      item: item,
                      isActive: item.value == widget.value,
                      onSelect: () {
                        try {
                          widget.onSelect?.call(item);
                          Navigator.of(context).maybePop();
                        } catch (err) {
                          if (kDebugMode) {
                            print(err);
                          }
                        }
                      },
                    )))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _SelectItemWidget extends StatefulWidget {
  const _SelectItemWidget({
    required this.item,
    this.isActive = false,
    this.onSelect,
  });
  final SelectItem item;
  final bool isActive;
  final Function()? onSelect;

  @override
  State<_SelectItemWidget> createState() => __SelectItemWidgetState();
}

class __SelectItemWidgetState extends State<_SelectItemWidget> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: widget.onSelect,
      onHover: (state) => setState(() => isHover = state),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
            color: AppTheme.of(context).selection.withOpacity(isHover
                ? 0.12
                : widget.isActive
                    ? 0.16
                    : 0)),
        child: widget.item.child,
      ),
    );
  }
}

class SelectItem<T extends dynamic> {
  SelectItem({
    required this.value,
    required this.child,
  });
  final T value;
  final Widget child;
}
