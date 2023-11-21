import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';

class KlinThemeProvider {}

class KlinAppTheme {
  String name;
  Color primary;
  Color selection;
  TerminalTheme terminalTheme;

  KlinAppTheme({
    this.name = "Unknown",
    required this.primary,
    required this.selection,
    required this.terminalTheme,
  });

  Map toMap() {
    return {
      "name": name,
      "primary": primary.value,
      "selection": selection.value,
      "colors": {
        "cursor": terminalTheme.cursor.value,
        "selection": terminalTheme.selection.value,
        "foreground": terminalTheme.foreground.value,
        "background": terminalTheme.background.value,
        "black": terminalTheme.black.value,
        "red": terminalTheme.red.value,
        "green": terminalTheme.green.value,
        "yellow": terminalTheme.yellow.value,
        "blue": terminalTheme.blue.value,
        "magenta": terminalTheme.magenta.value,
        "cyan": terminalTheme.cyan.value,
        "white": terminalTheme.white.value,
        "bright_black": terminalTheme.brightBlack.value,
        "bright_red": terminalTheme.brightRed.value,
        "bright_green": terminalTheme.brightGreen.value,
        "bright_yellow": terminalTheme.brightYellow.value,
        "bright_blue": terminalTheme.brightBlue.value,
        "bright_magenta": terminalTheme.brightMagenta.value,
        "bright_cyan": terminalTheme.brightCyan.value,
        "bright_white": terminalTheme.brightWhite.value,
        "search_hit_background": terminalTheme.searchHitBackground.value,
        "search_hit_background_current":
            terminalTheme.searchHitBackgroundCurrent.value,
        "search_hit_foreground": terminalTheme.searchHitForeground.value,
      }
    };
  }

  static KlinAppTheme fromMap(Map data) {
    Map colors = (data['colors'] as Map)
        .map((key, value) => MapEntry(key, Color(value)));

    return KlinAppTheme(
      name: data['name'],
      primary: Color(data['primary']),
      selection: Color(data['selection']),
      terminalTheme: TerminalTheme(
        cursor: colors['cursor'],
        selection: colors['selection'],
        foreground: colors['foreground'],
        background: colors['background'],
        black: colors['black'],
        white: colors['white'],
        red: colors['red'],
        green: colors['green'],
        yellow: colors['yellow'],
        blue: colors['blue'],
        magenta: colors['magenta'],
        cyan: colors['cyan'],
        brightBlack: colors['bright_black'],
        brightRed: colors['bright_red'],
        brightGreen: colors['bright_green'],
        brightYellow: colors['bright_yellow'],
        brightBlue: colors["bright_blue"],
        brightMagenta: colors['bright_magenta'],
        brightCyan: colors['bright_cyan'],
        brightWhite: colors['bright_white'],
        searchHitBackground: colors['search_hit_background'],
        searchHitBackgroundCurrent: colors['search_hit_background_current'],
        searchHitForeground: colors['search_hit_foreground'],
      ),
    );
  }

  ThemeData toMaterialLightTheme() {
    return toMaterialDarkTheme();
    // return ThemeData.light().copyWith(
    //   colorScheme: ColorScheme.light(
    //     primary: selection,
    //   ),
    // );
  }

  ThemeData toMaterialDarkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.dark(
        primary: selection,
      ),
    );
  }

  @override
  String toString() {
    return json.encode(toMap());
  }
}
