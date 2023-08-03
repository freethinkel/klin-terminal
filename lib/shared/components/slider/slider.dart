import 'package:flutter/cupertino.dart';

class OshmesSlider extends StatefulWidget {
  const OshmesSlider({
    required this.value,
    required this.onChanged,
    this.label,
    super.key,
  });
  final double value;
  final String? label;
  final Function(double value) onChanged;

  @override
  State<OshmesSlider> createState() => _OshmesSliderState();
}

class _OshmesSliderState extends State<OshmesSlider> {
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
