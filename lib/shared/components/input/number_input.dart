import 'package:klin/shared/components/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KlinNumberInput extends StatefulWidget {
  const KlinNumberInput({
    this.placeholder,
    super.key,
  });
  final String? placeholder;

  @override
  State<KlinNumberInput> createState() => _KlinNumberInputState();
}

class _KlinNumberInputState extends State<KlinNumberInput> {
  @override
  Widget build(BuildContext context) {
    return KlinInput(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]*')),
      ],
    );
  }
}
