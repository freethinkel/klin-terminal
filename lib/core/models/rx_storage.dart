import 'package:cheber_terminal/core/models/rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RxStateStorage<T> extends RxState<T> {
  String key;
  T? Function(String value) mapper;
  RxStateStorage(this.key, this.mapper, [T? initialValue])
      : super(initialValue) {
    _init();
  }

  _init() async {
    var instance = await SharedPreferences.getInstance();
    var cachedValue = instance.getString(key);
    T? value =
        cachedValue != null ? mapper(cachedValue) ?? this.value : this.value;
    if (value != null) {
      next(value);
    }
    stream.listen((event) async {
      await instance.setString(key, event.toString());
    });
  }
}
