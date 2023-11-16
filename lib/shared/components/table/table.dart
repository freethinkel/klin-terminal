import 'package:flutter/material.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';

typedef KlinTableRow = List<Widget>;

class KlinTable extends StatefulWidget {
  final KlinTableRow headers;
  final List<KlinTableRow> rows;
  final Map<int, TableColumnWidth>? columnWidth;
  const KlinTable({
    required this.headers,
    required this.rows,
    this.columnWidth,
    super.key,
  });

  @override
  State<KlinTable> createState() => _KlinTableState();
}

class _KlinTableState extends State<KlinTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppTheme.of(context).selection.withOpacity(0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Table(
          columnWidths: widget.columnWidth,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: AppTheme.of(context).selection.withOpacity(0.08),
              ),
              children: widget.headers
                  .map(
                    (cell) => TableCell(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: DefaultTextStyle.of(context)
                              .style
                              .color
                              ?.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: cell,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            ...widget.rows.map(
              (row) => TableRow(
                children: row
                    .map(
                      (cell) => TableCell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppTheme.of(context)
                                    .selection
                                    .withOpacity(0.1),
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: cell,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
