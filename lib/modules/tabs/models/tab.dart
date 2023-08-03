import 'package:oshmes_terminal/core/models/rx.dart';
import 'package:oshmes_terminal/modules/terminal/models/terminal_node.dart';

class TabNode {
  TabNode({
    required this.uuid,
  });
  RxState<String> title = RxState("");
  String uuid;

  TerminalNode? lastFocusedNode;
}
