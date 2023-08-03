import 'package:oshmes_terminal/shared/components/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OshmesNumberInput extends StatefulWidget {
  const OshmesNumberInput({
    this.placeholder,
    super.key,
  });
  final String? placeholder;

  @override
  State<OshmesNumberInput> createState() => _OshmesNumberInputState();
}

class _OshmesNumberInputState extends State<OshmesNumberInput> {
  @override
  Widget build(BuildContext context) {
    return OshmesInput(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]*')),
      ],
    );
  }
}
