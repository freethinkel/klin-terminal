import 'package:klin/core/widgets/controller_connector.dart';
import 'package:klin/modules/settings/controllers/settings.controller.dart';
import 'package:klin/modules/tabs/models/tab.dart';
import 'package:klin/modules/tabs/screens/context_menu_connector.dart';
import 'package:klin/modules/terminal/models/terminal_node.dart';
import 'package:klin/modules/terminal/screens/attached_terminal_view.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

class TabViewTree extends StatefulWidget {
  const TabViewTree({
    required this.terminalNode,
    required this.tabNode,
    required this.onClose,
    super.key,
  });
  final TerminalNode terminalNode;
  final TabNode tabNode;
  final Function(TerminalNode node) onClose;

  @override
  State<TabViewTree> createState() => _TabViewTreeState();
}

class _TabViewTreeState extends State<TabViewTree> {
  late TerminalNode _terminalNode = widget.terminalNode;
  set terminalNode(TerminalNode node) {
    _terminalNode = node;
    _updateListeners();
  }

  TerminalNode get terminalNode => _terminalNode;

  void _onSplit(Axis axis) {
    var parent = terminalNode.parent;
    var newNode = TerminalNode(
      children: [
        terminalNode,
        TerminalNode(),
      ],
      parent: parent,
      splitAxis: axis,
    );
    for (var item in newNode.children) {
      item.parent = newNode;
    }
    setState(() {
      terminalNode = newNode;
    });
  }

  void _onClose(TerminalNode node) {
    if (terminalNode.children.isEmpty) {
      return;
    }
    final newNode =
        terminalNode.children.firstWhere((element) => element != node);
    setState(() {
      terminalNode = newNode;
    });
    node.dispose();
  }

  _updateListeners() {
    terminalNode.onChangeTitle = (newTitle) {
      widget.tabNode.title.next(newTitle);
    };
    terminalNode.onExit = () => widget.onClose(terminalNode);
    terminalNode.focusNode.removeListener(_onChangeFocus);
    terminalNode.focusNode.addListener(_onChangeFocus);
    terminalNode.splitPane = _onSplit;
  }

  _onChangeFocus() {
    if (terminalNode.focusNode.hasFocus) {
      widget.tabNode.lastFocusedNode = terminalNode;
      widget.tabNode.title.next(terminalNode.title);
    }
  }

  final _settingsController = ControllerConnector.of<SettingsController>();
  bool enableContextMenu = true;
  @override
  void initState() {
    widget.tabNode.lastFocusedNode = terminalNode;
    setState(() {
      enableContextMenu = _settingsController.enableContextMenu$.value == true;
    });
    _settingsController.enableContextMenu$.stream.listen((event) {
      if (event != enableContextMenu) {
        setState(() => enableContextMenu = event);
      }
    });
    _updateListeners();
    super.initState();
  }

  @override
  void dispose() {
    terminalNode.focusNode.removeListener(_onChangeFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (terminalNode.children.isNotEmpty) {
      return MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
          dividerPainter: DividerPainter(
            backgroundColor:
                AppTheme.colorWithLightness(AppTheme.of(context).primary, 0.1),
            highlightedBackgroundColor: AppTheme.of(context).selection,
          ),
          dividerThickness: 2,
        ),
        child: MultiSplitView(
          axis: terminalNode.splitAxis,
          children: terminalNode.children
              .map(
                (node) => TabViewTree(
                  terminalNode: node,
                  tabNode: widget.tabNode,
                  onClose: _onClose,
                ),
              )
              .toList(),
        ),
      );
    }

    Widget child = AttachedTerminal(
      key: Key(terminalNode.uuid),
      terminalNode: terminalNode,
    );

    if (enableContextMenu) {
      child = ContextMenuConnector(
        terminalNode: terminalNode,
        onSplit: _onSplit,
        child: child,
      );
    }

    return child;
  }
}
