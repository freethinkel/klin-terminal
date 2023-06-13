import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheberInput extends StatefulWidget {
  const CheberInput({
    this.label,
    this.placeholder,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
    super.key,
  });
  final String? label;
  final String? placeholder;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  State<CheberInput> createState() => _CheberInputState();
}

class _CheberInputState extends State<CheberInput> {
  late final _focusNode = widget.focusNode ?? FocusNode();
  var isFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocus = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              widget.label ?? "",
              style: TextStyle(
                fontSize: 11,
                color:
                    DefaultTextStyle.of(context).style.color?.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: AppTheme.of(context).selection.withOpacity(0.08),
            border: Border.all(
              color: AppTheme.of(context)
                  .selection
                  .withOpacity(isFocus ? 0.24 : 0.12),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            decoration:
                InputDecoration.collapsed(hintText: widget.placeholder ?? "")
                    .copyWith(
              constraints: const BoxConstraints(minWidth: 10),
              contentPadding:
                  const EdgeInsets.only(top: 8, left: 6, right: 6, bottom: 10),
            ),
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
