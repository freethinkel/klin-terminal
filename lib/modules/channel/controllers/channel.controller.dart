import 'package:flutter/services.dart';
import 'package:rx_flow/rx_flow.dart';

class ChannelController extends IController {
  final _channelName = 'ru.freethinkel.klinterminal/channel';
  late final channel = MethodChannel(_channelName);

  final maximized$ = RxState(false);
  final fullscreened$ = RxState(false);

  @override
  void init() {
    channel.setMethodCallHandler((call) async {
      var _ = switch (call.method) {
        'maximized' => maximized$.next(true),
        'unmaximized' => maximized$.next(false),
        'enter-full-screen' => fullscreened$.next(true),
        'leave-full-screen' => fullscreened$.next(false),
        _ => null
      };
    });
  }

  Future<void> startDragging() async {
    await channel.invokeMethod("start_dragging");
  }

  Future<bool> isMaximized() async {
    var isMaximized = await channel.invokeMethod("is_maximized");
    return isMaximized == true;
  }

  Future<void> maximize() async {
    await channel.invokeMethod("maximize");
  }

  Future<void> unmaximize() async {
    await channel.invokeMethod("unmaximize");
  }
}
