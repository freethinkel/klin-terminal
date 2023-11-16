import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:klin/core/models/controller.dart';
import 'package:klin/core/models/rx.dart';
import 'package:klin/core/models/rx_storage.dart';
import 'package:klin/modules/theme/models/theme.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yaml/yaml.dart';

final _definedThemes = [
  'klin_dark',
  'default_dark',
  'solarized_dark',
  'tokyo_night',
  'nord_dark',
  'gruvbox',
];

class ThemeController extends IController {
  final currentThemeName$ = RxStateStorage<String>(
    "currentThemeName",
    mapper: (name) => name.toString(),
    initialValue: "Klin",
  );
  late final theme$ = RxState.fromSubject<KlinAppTheme?>(BehaviorSubject()
    ..addStream(
      Rx.combineLatest2(
        themes$.stream,
        currentThemeName$.stream,
        (themes, currentTheme) =>
            themes.firstWhereOrNull((theme) => theme.name == currentTheme),
      ),
    ));
  final themes$ = RxState<List<KlinAppTheme>>([]);
  final _backgroundImagePath = RxStateStorage(
    "theme_background_image_path",
    mapper: (value) => value,
  );
  late final backgroundImage$ =
      _backgroundImagePath.map((path) => path.isNotEmpty ? File(path) : null);

  @override
  Future<void> init() async {
    final themes = await Future.wait(
      _definedThemes.map(
        (theme) => rootBundle
            .loadString('lib/modules/theme/themes/$theme.yml')
            .then(loadYaml)
            .then(
              (yaml) => KlinAppTheme.fromMap(yaml),
            ),
      ),
    );
    themes$.next(themes);
  }

  void setTheme(KlinAppTheme theme) {
    currentThemeName$.next(theme.name);
  }

  void setBackgroundImage(File? file) {
    _backgroundImagePath.next(file?.path ?? "");
  }
}
