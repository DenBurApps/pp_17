import 'dart:async';

/// Класс EventBus представляет реализацию системы событий в виде потоков событий.
class EventBus {
  final _controller = StreamController<Event>.broadcast();

  /// Получает общий поток событий.
  Stream<Event> get _stream => _controller.stream;

  /// Возвращает поток событий с определенным типом T.
  Stream<T> stream<T extends Event>() {
    return _stream.where((event) => event is T).cast<T>();
  }

  /// Добавляет событие в поток.
  void addEvent(Event event) {
    _controller.sink.add(event);
  }
}

/// Класс Event представляет базовый класс для определения пользовательских событий,
/// используемых в EventBus.
class Event {}

class News implements Event {}

class Settings implements Event {}