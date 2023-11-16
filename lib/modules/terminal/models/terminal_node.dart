import 'package:klin/modules/terminal/models/terminal_node_pty.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:xterm/xterm.dart';

class TerminalNode extends TerminalNodePty {
  TerminalNode({
    this.children = const [],
    this.parent,
    this.splitAxis = Axis.vertical,
  });

  Axis splitAxis;
  TerminalNode? parent;
  List<TerminalNode> children;

  Function(Axis direction)? splitPane;

  void sendChars(String chars) {
    terminal.textInput(chars);
  }

  void clear() {
    terminal.keyInput(TerminalKey.keyL, ctrl: true);
  }

  void focusPane(AxisDirection direction) {
    TerminalNode? getParent(TerminalNode? node, Axis axis) {
      if (node == null) {
        return null;
      }
      return node.splitAxis == axis ? node : getParent(node.parent, axis);
    }

    var axis = AxisDirection.down == direction || AxisDirection.up == direction
        ? Axis.vertical
        : Axis.horizontal;
    var parent = getParent(this.parent, axis);

    if (parent == null) {
      return;
    }
    var isPrev =
        direction == AxisDirection.up || direction == AxisDirection.left;
    var node = parent.children[isPrev ? 0 : 1];
    node.focusNode.requestFocus();
  }
}
