import 'dart:io';

class ShellCommand {
  final String command;

  final List<String> args;

  ShellCommand(this.command, this.args);
}

ShellCommand platformShell({
  String? workingDirectory,
}) {
  if (Platform.isMacOS) {
    final user = Platform.environment['USER'];

    // if (workingDirectory != null) {
    //   return ShellCommand(
    //       "sh", ['-c', 'cd $workingDirectory; login -fpl $user']);
    // }

    return ShellCommand("/bin/zsh", []);
    return ShellCommand('login', ['-fp', user!]);
  }

  if (Platform.isWindows) {
    return ShellCommand('cmd.exe', []);
  }

  final shell = Platform.environment['SHELL'] ?? 'sh';
  return ShellCommand(shell, []);
}
