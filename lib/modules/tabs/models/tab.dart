import 'package:flutter/material.dart';

class TabNode {
  TabNode({
    required this.title,
    required this.child,
    required this.uuid,
  });
  String uuid;
  String title;
  Widget child;
}
