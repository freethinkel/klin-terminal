import 'package:flutter/material.dart';
import 'package:oshmes_terminal/modules/theme/components/theme_connector.dart';

typedef OshmesTableRow = List<Widget>;

class OshmesTable extends StatefulWidget {
  final OshmesTableRow headers;
  final List<OshmesTableRow> rows;
  final Map<int, TableColumnWidth>? columnWidth;
  const OshmesTable({
    required this.headers,
    required this.rows,
    this.columnWidth,
    super.key,
  });

  @override
  State<OshmesTable> createState() => _OshmesTableState();
}

class _OshmesTableState extends State<OshmesTable> {
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
