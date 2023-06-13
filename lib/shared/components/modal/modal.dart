import 'package:cheber_terminal/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart';

Future<void> openModa(BuildContext context, Widget child) async {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "CheberModal",
    useRootNavigator: false,
    barrierColor: Colors.transparent,
    builder: (context) => _Modal(child: child),
  );
}

class __ModalState extends State<_Modal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.of(context).primary.withOpacity(1),
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}

class _Modal extends StatefulWidget {
  final Widget child;
  const _Modal({
    required this.child,
  });

  @override
  State<_Modal> createState() => __ModalState();
}
