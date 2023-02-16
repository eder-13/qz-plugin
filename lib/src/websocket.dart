@JS('qz.websocket')
library qz_websocket;

import 'package:js/js.dart';
import 'dart:js_util';

class QzWebsocket {
  Future<dynamic> connect() async {
    if (!isActive()) {
      return promiseToFuture(_connect());
    }
  }

  Future<dynamic> disconnect() async {
    if (isActive()) {
      return promiseToFuture(_disconnect());
    }
  }

  bool isActive() => _isActive();
}

@JS('connect')
external dynamic _connect();

@JS('disconnect')
external dynamic _disconnect();

@JS('isActive')
external bool _isActive();
