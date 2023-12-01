import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:klin/modules/terminal/models/shell.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:uuid/uuid.dart';
import 'package:xterm/xterm.dart';

class TerminalNodePty {
  TerminalNodePty({
    required this.initialWorkingDirectory,
  });

  final String? initialWorkingDirectory;

  final FocusNode focusNode = FocusNode();
  late final terminalController = TerminalController();
  late final terminal = Terminal(
    macOptionIsMeta: true,
  );
  final uuid = const Uuid().v4();

  String title = "";

  Function(String)? onChangeTitle;
  Function()? onExit;

  Pty? _pty;
  ShellCommand? _shell;

  Pty get pty => _pty!;

  var _initialized = false;

  Future<String?> getCwd() async {
    try {
      var process = await Process.run("lsof", ["-p", (pty.pid).toString()]);

      if ((process.stdout ?? "").toString().isEmpty) {
        process = await Process.run("lsof", ["-p", (pty.pid + 1).toString()]);
      }

      final lines = process.stdout.toString().trim().split(RegExp("\\n"));
      final line = lines.firstWhereOrNull((line) => line.contains("cwd"));
      final path = line?.split(RegExp("\\s+")).last;

      return path;
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
      return null;
    }
  }

  void init() async {
    if (_initialized) {
      return;
    }

    _shell = platformShell();
    _pty = Pty.start(
      _shell!.command,
      arguments: _shell!.args,
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
      workingDirectory: initialWorkingDirectory ?? Platform.environment["HOME"],
      environment: {
        ...Platform.environment,
        "TERM": "xterm-256color",
      },
    );

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
    try {
      pty.kill(ProcessSignal.sigkill);
    } catch (err) {
      print(err);
    }
  }
}
