import 'dart:io';

class ShellCommand {
  final String command;

  final List<String> args;

  ShellCommand(this.command, this.args);
}

ShellCommand get platformShell {
  if (Platform.isMacOS) {
    final user = Platform.environment['USER'];
    return ShellCommand('login', ['-fp', user!]);
  }

  if (Platform.isWindows) {
    return ShellCommand('cmd.exe', []);
  }

  final shell = Platform.environment['SHELL'] ?? 'sh';
  return ShellCommand(shell, []);
}
