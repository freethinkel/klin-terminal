import 'package:flutter/material.dart';
import 'package:klin/modules/settings/models/constants.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/button/button.dart';
import 'package:klin/shared/components/icon/icon.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

class InputControlNumber extends StatefulWidget {
  const InputControlNumber({
    required this.title,
    required this.value,
    this.onChanged,
    this.min = 0,
    this.max = 1,
    this.step = 0.1,
    super.key,
  });
  final String title;
  final double value;
  final double min;
  final double max;
  final double step;
  final Function(double)? onChanged;

  @override
  State<InputControlNumber> createState() => _InputControlState();
}

class _InputControlState extends State<InputControlNumber> {
  final focusedNode = FocusNode();
  late final controller = TextEditingController(text: widget.value.toString());

  bool isFocused = false;

  void changeValue(double? value) {
    double newValue = widget.min;
    if (value == null) {
      // widget.onChanged?.call(widget.min);
      newValue = widget.min;
    } else {
      newValue = (value!.clamp(widget.min, widget.max));
    }

    widget.onChanged?.call(newValue);
    controller.text = newValue.toString();
  }

  @override
  void initState() {
    focusedNode.addListener(() {
      setState(() {
        isFocused = focusedNode.hasFocus;
      });

      if (!focusedNode.hasFocus) {
        changeValue(double.tryParse(controller.text));
      }
    });
    super.initState();
  }

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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppTheme.of(context).selection.withOpacity(0.3),
                border: Border.all(
                    color: AppTheme.of(context)
                        .selection
                        .withOpacity(isFocused ? 0.4 : 0),
                    width: 2),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color:
                              AppTheme.of(context).selection.withOpacity(0.5),
                        ),
                      ),
                    ),
                    width: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        focusNode: focusedNode,
                        autofocus: true,
                        controller: controller,
                        style: const TextStyle(fontSize: 14, height: 1.1),
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  KlinButton(
                      onTap: () {
                        changeValue(
                            double.parse(controller.text) - widget.step);
                      },
                      kind: KlinButtonKind.clean,
                      size: KlinButtonSize.small,
                      child: const Icon(
                        TablerIcons.minus,
                        size: 16,
                      )),
                  KlinButton(
                      onTap: () {
                        changeValue(
                            double.parse(controller.text) + widget.step);
                      },
                      size: KlinButtonSize.small,
                      kind: KlinButtonKind.clean,
                      child: const Icon(
                        TablerIcons.plus,
                        size: 16,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
