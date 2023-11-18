import 'package:flutter/widgets.dart';
import 'package:klin/modules/channel/services/channel.service.dart';
import 'package:klin/modules/mappings/services/shortcuts.service.dart';
import 'package:klin/modules/tabs/controllers/tabs.controller.dart';
import 'package:rx_flow/rx_flow.dart';

class WindowManagerController extends IController {
  WindowManagerController({
    required TabsController tabsController,
    required ShortcutsService shortcutsService,
    required ChannelService channelService,
  })  : _tabsController = tabsController,
        _shortcutsService = shortcutsService,
        _channelService = channelService {
    _channelService.focused$.stream
        .listen((event) => event ? _onWindowFocus() : _onWindowBlur());
  }

  late final fullscreened$ = _channelService.fullscreened$;
  late final maximized$ = _channelService.maximized$;

  final ShortcutsService _shortcutsService;
  final TabsController _tabsController;
  final ChannelService _channelService;

  void _onWindowBlur() {
    FocusManager.instance.primaryFocus?.unfocus();
    _shortcutsService.clearPressedKeys();
  }

  void _onWindowFocus() {
    FocusManager.instance.primaryFocus?.requestFocus();
    _tabsController.currentTab$.value?.lastFocusedNode?.focusNode
        .requestFocus();
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
