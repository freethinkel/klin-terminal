import 'dart:async';

import 'package:klin/core/models/controller.dart';
import 'package:klin/core/models/rx.dart';
import 'package:klin/core/widgets/controller_connector.dart';
import 'package:flutter/cupertino.dart';

abstract class StateWatcher {
  C controller<C extends IController>();
  T? watch<T>(RxState<T> state);
}

class StateWatcherImpl implements StateWatcher {
  const StateWatcherImpl({
    required this.onRegisterState,
  });
  final Function(RxState) onRegisterState;
  @override
  C controller<C extends IController>() {
    return ControllerConnector.of<C>();
  }

  @override
  T? watch<T>(RxState<T> state) {
    onRegisterState(state);
    return state.value;
  }
}

abstract class RxConsumer extends StatefulWidget {
  const RxConsumer({super.key});
  Widget build(BuildContext context, StateWatcher watcher);

  void onInit() {}

  @override
  // ignore: library_private_types_in_public_api
  _ConsumerState createState() => _ConsumerState();
}

class _ConsumerState extends State<RxConsumer> {
  final Set<RxState> _states = {};
  List<StreamSubscription> _subscriptions = [];
  late final watcher = StateWatcherImpl(onRegisterState: (state) {
    if (_states.contains(state)) {
      return;
    }
    _states.add(state);
    _onUpdate();
  });

  _onUpdate() {
    _unlisten();
    for (var state in _states) {
      _subscriptions.add(state.stream.listen((event) {
        setState(() {});
      }));
    }
  }

  void _unlisten() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions = [];
  }

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void dispose() {
    _unlisten();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, watcher);
  }
}
