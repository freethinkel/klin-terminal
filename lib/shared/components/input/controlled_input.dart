import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klin/shared/components/input/input.dart';

class ControlledKlinInput extends StatefulWidget {
  const ControlledKlinInput({
    required this.value,
    required this.onInput,
    this.label,
    this.placeholder,
    this.inputFormatters,
    super.key,
  });
  final String value;
  final String? placeholder;
  final String? label;
  final Function(String value) onInput;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<ControlledKlinInput> createState() => _ControlledKlinInputState();
}

class _ControlledKlinInputState extends State<ControlledKlinInput> {
  late final _controller = TextEditingController(text: widget.value);

  @override
  void initState() {
    _controller.addListener(() {
      if (widget.value != _controller.text) {
        widget.onInput(_controller.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KlinInput(
      label: widget.label,
      placeholder: widget.placeholder,
      controller: _controller,
      inputFormatters: widget.inputFormatters,
    );
  }
}
