import 'package:cheber_terminal/shared/components/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheberNumberInput extends StatefulWidget {
  const CheberNumberInput({
    this.placeholder,
    super.key,
  });
  final String? placeholder;

  @override
  State<CheberNumberInput> createState() => _CheberNumberInputState();
}

class _CheberNumberInputState extends State<CheberNumberInput> {
  @override
  Widget build(BuildContext context) {
    return CheberInput(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]*')),
      ],
    );
  }
}
