import 'dart:async';
import 'dart:ui';

class Message<T> {
  Message(this.key, this.data);
  String key;
  T data;
}

class BusService {
  factory BusService() {
    return _singleton;
  }

  BusService._internal();
  static final BusService _singleton = BusService._internal();

  StreamController<Message<dynamic>> bus =
      StreamController<Message<dynamic>>.broadcast();

  static void sendMessage(Message<dynamic> message) {
    BusService().bus.sink.add(message);
  }

  static void listenMessageWithKey(String key, VoidCallback onCallBack) {
    BusService().bus.stream.listen((Message<dynamic> event) {
      if (event.key == key) {
        onCallBack();
      }
    });
  }
}
