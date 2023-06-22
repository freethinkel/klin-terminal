import 'package:cheber_terminal/core/models/controller.dart';
import 'package:cheber_terminal/modules/mappings/models/intents.dart';
import 'package:cheber_terminal/modules/mappings/models/shortcuts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MappingsController extends IController {
  final mappings = const [
    Mapping(
      key: "open_new_tab",
      activator: SingleActivator(
        LogicalKeyboardKey.keyT,
        meta: true,
      ),
      intent: NewTabMappingAction(),
    ),
    Mapping(
      key: "close_tab",
      activator: SingleActivator(
        LogicalKeyboardKey.keyW,
        meta: true,
      ),
      intent: CloseTabMappingAction(),
    ),
    Mapping(
      key: "next_tab",
      activator: SingleActivator(
        LogicalKeyboardKey.tab,
        control: true,
      ),
      intent: NextTabMappingAction(),
    ),
    Mapping(
      key: "prev_tab",
      activator: SingleActivator(
        LogicalKeyboardKey.tab,
        control: true,
        shift: true,
      ),
      intent: PrevTabMappingAction(),
    ),
    Mapping(
      key: "_internal_next_tab",
      activator: SingleActivator(
        LogicalKeyboardKey.braceRight,
        meta: true,
        shift: true,
      ),
      intent: NextTabMappingAction(),
    ),
    Mapping(
      key: "_internal_prev_tab",
      activator: SingleActivator(
        LogicalKeyboardKey.braceLeft,
        meta: true,
        shift: true,
      ),
      intent: PrevTabMappingAction(),
    ),
    Mapping(
      key: "set_tab_1",
      activator: SingleActivator(
        LogicalKeyboardKey.digit1,
        meta: true,
      ),
      intent: SetTabMappingAction(1),
    ),
    Mapping(
      key: "set_tab_2",
      activator: SingleActivator(
        LogicalKeyboardKey.digit2,
        meta: true,
      ),
      intent: SetTabMappingAction(2),
    ),
    Mapping(
      key: "set_tab_3",
      activator: SingleActivator(
        LogicalKeyboardKey.digit3,
        meta: true,
      ),
      intent: SetTabMappingAction(3),
    ),
    Mapping(
      key: "set_tab_4",
      activator: SingleActivator(
        LogicalKeyboardKey.digit4,
        meta: true,
      ),
      intent: SetTabMappingAction(4),
    ),
    Mapping(
      key: "set_tab_5",
      activator: SingleActivator(
        LogicalKeyboardKey.digit5,
        meta: true,
      ),
      intent: SetTabMappingAction(5),
    ),
    Mapping(
      key: "set_tab_6",
      activator: SingleActivator(
        LogicalKeyboardKey.digit6,
        meta: true,
      ),
      intent: SetTabMappingAction(6),
    ),
    Mapping(
      key: "set_tab_7",
      activator: SingleActivator(
        LogicalKeyboardKey.digit7,
        meta: true,
      ),
      intent: SetTabMappingAction(7),
    ),
    Mapping(
      key: "set_tab_8",
      activator: SingleActivator(
        LogicalKeyboardKey.digit8,
        meta: true,
      ),
      intent: SetTabMappingAction(8),
    ),
    Mapping(
      key: "set_tab_9",
      activator: SingleActivator(
        LogicalKeyboardKey.digit9,
        meta: true,
      ),
      intent: SetTabMappingAction(9),
    ),
    Mapping(
      key: "split_down",
      activator: SingleActivator(
        LogicalKeyboardKey.underscore,
        shift: true,
        meta: true,
        includeRepeats: false,
      ),
      intent: SplitDownMappingAction(),
    ),
    Mapping(
      key: "split_right",
      activator: SingleActivator(
        LogicalKeyboardKey.bar,
        shift: true,
        meta: true,
        includeRepeats: false,
      ),
      intent: SplitRightMappingAction(),
    ),
    Mapping(
      key: "close_terminal",
      activator: SingleActivator(
        LogicalKeyboardKey.keyX,
        meta: true,
      ),
      intent: CloseTerminalMappingAction(),
    ),
    Mapping(
      key: "focus_up",
      activator: SingleActivator(
        LogicalKeyboardKey.keyK,
        meta: true,
        includeRepeats: false,
      ),
      intent: FocusTerminalPaneMappingAction(
        direction: AxisDirection.up,
      ),
    ),
    Mapping(
      key: "focus_down",
      activator: SingleActivator(
        LogicalKeyboardKey.keyJ,
        meta: true,
        includeRepeats: false,
      ),
      intent: FocusTerminalPaneMappingAction(
        direction: AxisDirection.down,
      ),
    ),
    Mapping(
      key: "focus_left",
      activator: SingleActivator(
        LogicalKeyboardKey.keyH,
        meta: true,
        includeRepeats: false,
      ),
      intent: FocusTerminalPaneMappingAction(
        direction: AxisDirection.left,
      ),
    ),
    Mapping(
      key: "focus_right",
      activator: SingleActivator(
        LogicalKeyboardKey.keyL,
        meta: true,
        includeRepeats: false,
      ),
      intent: FocusTerminalPaneMappingAction(
        direction: AxisDirection.right,
      ),
    ),
  ];
}
