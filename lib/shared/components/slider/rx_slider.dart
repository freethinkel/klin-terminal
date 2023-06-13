import 'dart:async';

import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/shared/components/slider/slider.dart';
import 'package:flutter/material.dart';

class RxSlider extends StatefulWidget {
  const RxSlider({
    super.key,
    this.label,
    required this.state,
  });

  final String? label;
  final RxState<double> state;

  @override
  State<RxSlider> createState() => _RxSliderState();
}

class _RxSliderState extends State<RxSlider> {
  late double value = widget.state.value ?? 0;
  StreamSubscription? _subscription;

  @override
  void initState() {
    _subscription = widget.state.stream.listen((event) {
      if (value != event) {
        setState(() {
          value = event;
        });
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
    return CheberSlider(
        label: widget.label,
        value: value,
        onChanged: (newValue) {
          if (newValue != widget.state.value) widget.state.next(newValue);
        });
  }
}
