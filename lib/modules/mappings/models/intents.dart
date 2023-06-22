import 'package:flutter/widgets.dart';

class NewTabMappingAction extends Intent {
  const NewTabMappingAction();
}

class CloseTabMappingAction extends Intent {
  const CloseTabMappingAction();
}

class NextTabMappingAction extends Intent {
  const NextTabMappingAction();
}

class PrevTabMappingAction extends Intent {
  const PrevTabMappingAction();
}

class SetTabMappingAction extends Intent {
  const SetTabMappingAction(this.index);
  final int index;
}

class SplitDownMappingAction extends Intent {
  const SplitDownMappingAction();
}

class SplitRightMappingAction extends Intent {
  const SplitRightMappingAction();
}

class CloseTerminalMappingAction extends Intent {
  const CloseTerminalMappingAction();
}

class FocusTerminalPaneMappingAction extends Intent {
  const FocusTerminalPaneMappingAction({
    required this.direction,
  });
  final AxisDirection direction;
}
