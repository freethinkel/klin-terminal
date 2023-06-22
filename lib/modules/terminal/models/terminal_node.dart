import 'package:cheber_terminal/modules/terminal/models/terminal_node_pty.dart';
import 'package:flutter/widgets.dart';

class TerminalNode extends TerminalNodePty {
  TerminalNode({
    this.children = const [],
    this.parent,
    this.splitAxis = Axis.vertical,
  });

  Axis splitAxis;
  TerminalNode? parent;
  List<TerminalNode> children;
}
