import 'package:klin/modules/terminal/models/terminal_node.dart';
import 'package:rx_flow/rx_flow.dart';

class TabNode {
  TabNode({
    required this.uuid,
  });
  RxState<String> title = RxState("");
  String uuid;

  TerminalNode? lastFocusedNode;
}
