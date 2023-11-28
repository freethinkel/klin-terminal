import 'package:flutter/material.dart';
import 'package:klin/modules/settings/models/constants.dart';
import 'package:klin/shared/components/select/select.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

class SelectControl<T> extends StatefulWidget {
  const SelectControl({
    required this.title,
    this.value,
    this.items = const [],
    this.onChanged,
    super.key,
  });
  final String title;
  final T? value;
  final List<SelectItem<T>> items;
  final Function(T)? onChanged;

  @override
  State<SelectControl<T>> createState() => _SelectControlState<T>();
}

class _SelectControlState<T> extends State<SelectControl<T>> {
  @override
  Widget build(BuildContext context) {
    return Tappable(
      child: Container(
        height: ITEM_HEIGHT,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title),
                ],
              ),
            ),
            Select<T>(
              value: widget.value,
              items: widget.items,
              onSelect: (value) => widget.onChanged?.call(value.value),
            )
          ],
        ),
      ),
    );
  }
}
