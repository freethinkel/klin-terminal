import 'package:flutter/material.dart';
import 'package:klin/modules/settings/models/constants.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

class InputControlText extends StatefulWidget {
  const InputControlText({
    required this.title,
    this.value = '',
    this.placeholder,
    this.onChanged,
    super.key,
  });
  final String title;
  final String? placeholder;
  final String value;
  final Function(String)? onChanged;

  @override
  State<InputControlText> createState() => _InputControlTextState();
}

class _InputControlTextState extends State<InputControlText> {
  final focusedNode = FocusNode();
  late final controller = TextEditingController(text: widget.value);

  bool isFocused = false;

  @override
  void initState() {
    focusedNode.addListener(() {
      setState(() {
        isFocused = focusedNode.hasFocus;
      });

      if (!focusedNode.hasFocus) {
        widget.onChanged?.call(controller.text);
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
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                  child: Container(
                    width: 150,
                    height: 22,
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      focusNode: focusedNode,
                      controller: controller,
                      style: const TextStyle(fontSize: 14, height: 1.1),
                      decoration: InputDecoration.collapsed(
                              hintText: widget.placeholder ?? "")
                          .copyWith(
                        contentPadding: const EdgeInsets.all(4),
                      ),
                    ),
                  )),
            ])));
  }
}
