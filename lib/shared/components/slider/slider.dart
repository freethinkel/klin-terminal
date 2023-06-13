import 'package:flutter/cupertino.dart';

class CheberSlider extends StatefulWidget {
  const CheberSlider({
    required this.value,
    required this.onChanged,
    this.label,
    super.key,
  });
  final double value;
  final String? label;
  final Function(double value) onChanged;

  @override
  State<CheberSlider> createState() => _CheberSliderState();
}

class _CheberSliderState extends State<CheberSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        CupertinoSlider(
          value: widget.value,
          onChanged: widget.onChanged,
          min: 0,
          max: 1,
        ),
      ],
    );
  }
}
