import 'package:flutter/services.dart';
import 'package:rx_flow/rx_flow.dart';

class ChannelService extends IService {
  final _channelName = 'ru.freethinkel.klinterminal/channel';
  late final channel = MethodChannel(_channelName);

  final maximized$ = RxState(false);
  final fullscreened$ = RxState(false);
  final focused$ = RxState(false);

  void init() {
    channel.setMethodCallHandler((call) async {
      var _ = switch (call.method) {
        'maximized' => maximized$.next(true),
        'unmaximized' => maximized$.next(false),
        'enter-full-screen' => fullscreened$.next(true),
        'leave-full-screen' => fullscreened$.next(false),
        'blur' => focused$.next(false),
        'focus' => focused$.next(true),
        _ => null
      };
    });
  }

  Future<void> startWindowDragging() async {
    await channel.invokeMethod("start_dragging");
  }

  Future<bool> isWindowMaximized() async {
    var isMaximized = await channel.invokeMethod("is_maximized");
    return isMaximized == true;
  }

  Future<void> maximizeWindow() async {
    await channel.invokeMethod("maximize");
  }

  Future<void> unmaximizeWindow() async {
    await channel.invokeMethod("unmaximize");
  }

  Future<void> hideWidowButtons() async {
    await channel.invokeMethod("hide_buttons");
  }

  Future<void> showWindowButtons() async {
    await channel.invokeMethod("show_buttons");
  }
}
