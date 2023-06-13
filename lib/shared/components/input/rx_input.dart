import 'dart:async';

import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/shared/components/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RxInput<T> extends StatefulWidget {
  const RxInput({
    required this.state,
    this.label,
    this.placeholder,
    this.valueMap,
    this.inputFormatters,
    super.key,
  });
  final RxState<T> state;
  final Function(String value)? valueMap;
  final String? label;
  final String? placeholder;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<RxInput> createState() => _RxInputState();
}

class _RxInputState extends State<RxInput> {
  late final _controller =
      TextEditingController(text: widget.state.value.toString());
  final _focusNode = FocusNode();
  StreamSubscription? _subscription;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (widget.state.value.toString() != _controller.text) {
          widget.state.next(widget.valueMap != null
              ? widget.valueMap!(_controller.text)
              : _controller.text);
        }
      }
    });
    _subscription = widget.state.stream.listen((newValue) {
      if (_controller.text != newValue.toString()) {
        _controller.text = newValue.toString();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CheberInput(
      placeholder: widget.placeholder,
      label: widget.label,
      inputFormatters: widget.inputFormatters,
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}
