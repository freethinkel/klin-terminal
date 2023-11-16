import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:flutter/material.dart';

Future<void> openModal(BuildContext context, Widget child) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "KlinModal",
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
                color: AppTheme.of(context).primary,
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
