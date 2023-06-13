import 'package:rxdart/rxdart.dart';

class RxState<T> {
  RxState([T? value]) {
    this._controllableValue = _createSubject();
    this._value = _createSubject(value)..addStream(_controllableValue);
  }

  BehaviorSubject<T> _createSubject([T? value]) {
    return value != null
        ? BehaviorSubject<T>.seeded(value, sync: true)
        : BehaviorSubject<T>(sync: true);
  }

  late BehaviorSubject<T> _controllableValue;
  late BehaviorSubject<T> _value;

  RxState<T> addStream(Stream<T> stream) {
    _value = _createSubject(value)
      ..addStream(Rx.merge([stream, _controllableValue]));
    return this;
  }

  void next(T value) {
    _controllableValue.add(value);
  }

  Stream<T> get stream => this._value.stream;

  T? get value => this._value.valueOrNull;

  static RxState<T> fromSubject<T>(BehaviorSubject<T> subject, [map]) {
    return RxState<T>(subject.valueOrNull).addStream(subject);
  }

  RxState<M> map<M>(M Function(T) mapper) {
    return RxState<M>(value != null ? mapper(value as T) : null)
        .addStream(stream.map(mapper));
  }
}
