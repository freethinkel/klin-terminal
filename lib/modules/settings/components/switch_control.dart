import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klin/modules/settings/models/constants.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/switch/switch.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

class SwitchControl extends StatefulWidget {
  const SwitchControl({
    required this.title,
    required this.value,
    this.onChanged,
    this.description,
    super.key,
  });
  final String title;
  final String? description;
  final bool value;
  final Function(bool)? onChanged;

  @override
  State<SwitchControl> createState() => _SwitchControlState();
}

class _SwitchControlState extends State<SwitchControl> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Tappable(
        onHover: (state) => setState(() => isHover = state),
        onTap: () {
          widget.onChanged?.call(!widget.value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          constraints: BoxConstraints(minHeight: ITEM_HEIGHT),
          // height: ITEM_HEIGHT,
          decoration: BoxDecoration(
            color: AppTheme.of(context).primary.withOpacity(isHover ? 0.3 : 0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.title),
                    if (widget.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          widget.description!,
                          style: TextStyle(
                            fontSize: 11,
                            color: DefaultTextStyle.of(context)
                                .style
                                .color
                                ?.withOpacity(0.5),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: KlinSwitch(
                  value: widget.value,
                  onChanged: widget.onChanged,
                ),
              )
            ],
          ),
        ));
  }
}
