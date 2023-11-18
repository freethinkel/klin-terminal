import 'dart:convert';
import 'dart:io';

import 'package:klin/modules/terminal/models/shell.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:uuid/uuid.dart';
import 'package:xterm/xterm.dart';

class TerminalNodePty {
  final FocusNode focusNode = FocusNode();
  late final terminalController = TerminalController();
  late final terminal = Terminal();
  final uuid = const Uuid().v4();

  String title = "";

  Function(String)? onChangeTitle;
  Function()? onExit;

  final _shell = platformShell;
  late final _pty = Pty.start(
    _shell.command,
    arguments: _shell.args,
    columns: terminal.viewWidth,
    rows: terminal.viewHeight,
    workingDirectory: "/",
    environment: {
      ...Platform.environment,
      "TERM": "xterm-256color",
    },
  );

  Pty get pty => _pty;

  var _initialized = false;

  void init() {
    if (_initialized) {
      return;
    }

    _initialized = true;

    focusNode.requestFocus();
    pty.output
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
      Future.delayed(Duration.zero).then((value) {
        onExit?.call();
      });
    });

    terminal.onOutput = (data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };

    terminal.onTitleChange = (newTitle) {
      title = newTitle;
      onChangeTitle?.call(newTitle);
    };
  }

  void dispose() {
    pty.kill();
  }
}
