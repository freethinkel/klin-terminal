import 'package:flutter/widgets.dart';
import 'package:klin/modules/channel/services/channel.service.dart';
import 'package:klin/modules/mappings/services/shortcuts.service.dart';
import 'package:rx_flow/rx_flow.dart';

class WindowManagerController extends IController {
  WindowManagerController({
    required ShortcutsService shortcutsService,
    required ChannelService channelService,
  })  : _shortcutsService = shortcutsService,
        _channelService = channelService {
    _channelService.focused$.stream
        .listen((event) => event ? _onWindowFocus() : _onWindowBlur());
  }

  late final fullscreened$ = _channelService.fullscreened$;
  late final maximized$ = _channelService.maximized$;
  final focus$ = RxState(true);

  final ShortcutsService _shortcutsService;
  final ChannelService _channelService;

  void _onWindowBlur() {
    FocusManager.instance.primaryFocus?.unfocus();
    _shortcutsService.clearPressedKeys();
    focus$.next(false);
  }

  void _onWindowFocus() {
    FocusManager.instance.primaryFocus?.requestFocus();
    focus$.next(true);
  }

  Future<void> startDragging() async {
    await _channelService.startWindowDragging();
  }

  Future<bool> isMaximized() {
    return _channelService.isWindowMaximized();
  }

  Future<void> maximize() async {
    await _channelService.maximizeWindow();
  }

  Future<void> unmaximize() async {
    await _channelService.unmaximizeWindow();
  }

  Future<void> hideButtons() async {
    await _channelService.hideWidowButtons();
  }

  Future<void> showButtons() async {
    await _channelService.showWindowButtons();
  }
}
