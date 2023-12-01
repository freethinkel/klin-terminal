import 'dart:io';

class ShellCommand {
  final String command;

  final List<String> args;

  ShellCommand(this.command, this.args);
}

ShellCommand platformShell() {
  if (Platform.isMacOS) {
    final user = Platform.environment['USER'];

    return ShellCommand("/bin/zsh", ['-il']);
    // return ShellCommand('/usr/bin/login', [
    //   '-fpl',
    //   user!,
    //   "/Applications/iTerm.app/Contents/MacOS/ShellLauncher",
    //   "--launch_shell",
    //   "'SHELL=/bin/zsh'"
    // ]);
  }

  if (Platform.isWindows) {
    return ShellCommand('cmd.exe', []);
  }

  final shell = Platform.environment['SHELL'] ?? 'sh';
  return ShellCommand(shell, []);
}
