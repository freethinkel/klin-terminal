import 'package:flutter/material.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';

class ScopeCard extends StatefulWidget {
  const ScopeCard({
    required this.children,
    required this.title,
    super.key,
  });
  final List<Widget> children;
  final String title;

  @override
  State<ScopeCard> createState() => _ScopeCardState();
}

class _ScopeCardState extends State<ScopeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: DefaultTextStyle.of(context).style.color?.withOpacity(0.8),
            ),
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(
            color: DefaultTextStyle.of(context).style.color?.withOpacity(0.9),
          ),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.of(context).selection.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppTheme.of(context).selection.withOpacity(0.1)),
                ),
                child: Column(
                  children: widget.children
                      .map(
                        (item) => FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppTheme.of(context)
                                      .primary
                                      .withOpacity(
                                        item != widget.children.last ? 0.5 : 0,
                                      ),
                                ),
                              ),
                            ),
                            child: item,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
