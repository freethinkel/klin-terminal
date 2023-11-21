import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:klin/modules/theme/components/theme_connector.dart';
import 'package:klin/shared/components/button/button.dart';
import 'package:klin/shared/components/tappable/tappable.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({
    this.onSelect,
    this.image,
    this.label,
    super.key,
  });
  final Function(File?)? onSelect;
  final File? image;
  final String? label;

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  bool isHover = false;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result?.paths.first != null) {
      widget.onSelect?.call(File(result!.paths.first!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              widget.label ?? "",
              style: TextStyle(
                fontSize: 11,
                color:
                    DefaultTextStyle.of(context).style.color?.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (widget.image == null)
          Tappable(
            onTap: _pickFile,
            onHover: (state) => setState(() => isHover = state),
            child: Container(
              width: 200,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppTheme.of(context)
                    .terminalTheme
                    .cyan
                    .withOpacity(isHover ? 0.1 : 0.05),
                border: Border.all(
                  color: AppTheme.of(context).terminalTheme.cyan,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Opacity(
                    opacity: 0.7,
                    child: Icon(
                      Icons.image_rounded,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Select image",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DefaultTextStyle.of(context)
                          .style
                          .color
                          ?.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (widget.image != null)
          Container(
            width: 200,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppTheme.of(context).selection,
                width: 2,
              ),
            ),
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(
                    widget.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Row(
                  children: [
                    KlinButton(
                      onTap: () {
                        widget.onSelect?.call(null);
                      },
                      kind: KlinButtonKind.delete,
                      size: KlinButtonSize.small,
                      child: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
      ],
    );
  }
}
