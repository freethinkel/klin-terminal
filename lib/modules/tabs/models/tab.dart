import 'package:klin/core/models/rx.dart';
import 'package:klin/modules/terminal/models/terminal_node.dart';

class TabNode {
  TabNode({
    required this.uuid,
  });
  RxState<String> title = RxState("");
  String uuid;

  TerminalNode? lastFocusedNode;
}
