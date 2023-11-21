import 'package:flutter/material.dart';
import 'package:klin/modules/settings/models/constants.dart';
import 'package:klin/shared/components/slider/slider.dart';

class SliderControl extends StatefulWidget {
  const SliderControl({
    required this.value,
    required this.title,
    required this.onChanged,
    this.description,
    this.showValue,
    super.key,
  });
  final String title;
  final String? description;
  final double value;
  final Function(double) onChanged;
  final String? showValue;

  @override
  State<SliderControl> createState() => _SliderControlState();
}

class _SliderControlState extends State<SliderControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ITEM_HEIGHT,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title),
              if (widget.description != null) Text(widget.description!)
            ],
          )),
          KlinSlider(
            value: widget.value,
            onChanged: widget.onChanged,
          ),
          if (widget.showValue != null)
            SizedBox(width: 25, child: Text(widget.showValue!)),
        ],
      ),
    );
  }
}
