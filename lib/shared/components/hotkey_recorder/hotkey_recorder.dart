import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/logical_key_representation/logical_key_representation.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

// ignore: constant_identifier_names
const _MODIFIERS = [
  LogicalKeyboardKey.controlLeft,
  LogicalKeyboardKey.controlRight,
  LogicalKeyboardKey.shiftLeft,
  LogicalKeyboardKey.shiftRight,
  LogicalKeyboardKey.altLeft,
  LogicalKeyboardKey.altRight,
  LogicalKeyboardKey.metaLeft,
  LogicalKeyboardKey.metaRight,
];

class HotKeyRecorder extends StatefulWidget {
  const HotKeyRecorder({
    this.activator,
    this.onAccept,
    super.key,
  });
  final SingleActivator? activator;
  final Function(SingleActivator)? onAccept;

  @override
  State<HotKeyRecorder> createState() => _HotKeyRecorderState();
}

class _HotKeyRecorderState extends State<HotKeyRecorder> {
  final _focusNode = FocusNode();
  final Set<LogicalKeyboardKey> _pressedKeys = {};
  bool isFocused = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  Widget _buildPlaceholder() {
    return DefaultTextStyle(
      style: TextStyle(
          fontSize: 13,
          color: DefaultTextStyle.of(context).style.color?.withOpacity(0.6)),
      child: const Text("Record Hotkey"),
    );
  }

  Widget _buildActive() {
    return const DefaultTextStyle(
      style: TextStyle(
        fontSize: 13,
      ),
      child: Text("Recording..."),
    );
  }

  bool accepts(RawKeyEvent event) {
    final Set<LogicalKeyboardKey> pressed = _pressedKeys;
    var hasModifier =
        pressed.where((element) => _MODIFIERS.contains(element)).isNotEmpty;
    var hasExceptModifiers =
        pressed.where((element) => !_MODIFIERS.contains(element)).isNotEmpty;
    return event is RawKeyDownEvent && hasModifier && hasExceptModifiers;
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    } else if (event is RawKeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
    }

    setState(() {});

    final isAccepted = accepts(event);
    if (isAccepted) {
      _focusNode.unfocus();
      var key = _pressedKeys
          .firstWhereOrNull((element) => !_MODIFIERS.contains(element));
      widget.onAccept?.call(
        SingleActivator(
          key!,
          includeRepeats: false,
          control: _pressedKeys.contains(LogicalKeyboardKey.controlLeft) ||
              _pressedKeys.contains(LogicalKeyboardKey.controlRight),
          meta: _pressedKeys.contains(LogicalKeyboardKey.metaLeft) ||
              _pressedKeys.contains(LogicalKeyboardKey.metaRight),
          alt: _pressedKeys.contains(LogicalKeyboardKey.altLeft) ||
              _pressedKeys.contains(LogicalKeyboardKey.altRight),
          shift: _pressedKeys.contains(LogicalKeyboardKey.shiftLeft) ||
              _pressedKeys.contains(LogicalKeyboardKey.shiftRight),
        ),
      );
      _pressedKeys.clear();
    } else if (_pressedKeys.isEmpty) {
      _focusNode.unfocus();
    }
  }

  List<LogicalKeyboardKey> _activatorToKeyset(SingleActivator activator) {
    return [
      activator.meta ? LogicalKeyboardKey.meta : null,
      activator.control ? LogicalKeyboardKey.control : null,
      activator.alt ? LogicalKeyboardKey.alt : null,
      activator.shift ? LogicalKeyboardKey.shift : null,
      activator.trigger,
    ].whereType<LogicalKeyboardKey>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: _onKey,
      child: Tappable(
        onTap: () {
          _focusNode.requestFocus();
        },
        child: Focus(
          focusNode: _focusNode,
          onKey: (node, event) => KeyEventResult.handled,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.of(context).selection.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppTheme.of(context)
                    .selection
                    .withOpacity(isFocused ? 0.15 : 0.05),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: isFocused
                  ? _pressedKeys.isNotEmpty
                      ? DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.of(context).terminalTheme.cyan),
                          child: Wrap(
                            spacing: 3,
                            children: _pressedKeys
                                .map((key) =>
                                    LogicalKeyRepresentation(keyboardKey: key))
                                .toList(),
                          ),
                        )
                      : _buildActive()
                  : widget.activator != null
                      ? DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 13,
                              color: DefaultTextStyle.of(context)
                                  .style
                                  .color
                                  ?.withOpacity(0.8)),
                          child: Wrap(
                              spacing: 3,
                              children: _activatorToKeyset(widget.activator!)
                                  .map((item) => LogicalKeyRepresentation(
                                        keyboardKey: item,
                                      ))
                                  .toList()),
                        )
                      : _buildPlaceholder(),
            ),
          ),
        ),
      ),
    );
  }
}



    // return RawKeyboardListener(
    //   focusNode: FocusNode(),
    //   onKey: mappingController.onKey,
    //   child: Focus(
    //     onKey: (node, event) => mappingController.handled
    //         ? KeyEventResult.handled
    //         : KeyEventResult.ignored,
    //     child: child,
    //   ),
    // );
