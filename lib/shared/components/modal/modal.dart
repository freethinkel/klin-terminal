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
    return Stack(
      children: [
        IgnorePointer(
          child: Container(
            color: AppTheme.of(context).selection.withOpacity(0.2),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: Container(
            alignment: Alignment.center,
            child: IntrinsicHeight(
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 600, minHeight: 700),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppTheme.of(context).selection.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      color: AppTheme.of(context).primary.withOpacity(0.24),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ],
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
