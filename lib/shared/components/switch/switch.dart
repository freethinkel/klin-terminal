import 'package:flutter/cupertino.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';

class KlinSwitch extends StatelessWidget {
  const KlinSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });
  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 40,
      child: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          activeColor: AppTheme.of(context).selection,
          trackColor: AppTheme.of(context).primary,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
