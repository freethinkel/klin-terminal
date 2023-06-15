import 'dart:convert';

import 'package:cheber_terminal/core/models/controller.dart';
import 'package:cheber_terminal/core/models/rx.dart';
import 'package:cheber_terminal/core/models/rx_storage.dart';
import 'package:cheber_terminal/modules/theme/models/theme.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

final _definedThemes = [
  'default_dark',
  'solarized_dark',
  'tokyo_night',
];

class ThemeController extends IController {
  final theme$ = RxStateStorage<CheberAppTheme>(
    "currentAppTheme",
    mapper: (value) => CheberAppTheme.fromMap(
      json.decode(value),
    ),
  );
  final themes$ = RxState<List<CheberAppTheme>>([]);

  @override
  Future<void> init() async {
    final themes = await Future.wait(
      _definedThemes.map(
        (theme) => rootBundle
            .loadString('lib/modules/theme/themes/$theme.yml')
            .then(loadYaml)
            .then(
              (yaml) => CheberAppTheme.fromMap(yaml),
            ),
      ),
    );
    themes$.next(themes);
    if (theme$.value == null) {
      theme$.next(themes.first);
    }
  }
}
