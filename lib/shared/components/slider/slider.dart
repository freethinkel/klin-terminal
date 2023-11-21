import 'package:flutter/cupertino.dart';

class KlinSlider extends StatefulWidget {
  const KlinSlider({
    required this.value,
    required this.onChanged,
    this.label,
    super.key,
  });
  final double value;
  final String? label;
  final Function(double value) onChanged;

  @override
  State<KlinSlider> createState() => _KlinSliderState();
}

class _KlinSliderState extends State<KlinSlider> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSlider(
      value: widget.value,
      onChanged: widget.onChanged,
      min: 0,
      max: 1,
    );
  }
}
