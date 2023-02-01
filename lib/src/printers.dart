@JS('qz.printers')
library qz_printers;

import 'package:js/js.dart';
import 'dart:js_util';

import 'package:qz/src/websocket.dart';

class QzPrinters {
  Future<List<String>> findAll() async {
    await QzWebsocket().connect();
    List<dynamic> response = await promiseToFuture(_find());
    return response.map((printer) => (printer as String)).toList();
  }

  Future<String> findOne(String name) async {
    await QzWebsocket().connect();
    return promiseToFuture(_find(name));
  }

  Future<String> getDefault() async {
    await QzWebsocket().connect();
    return promiseToFuture(_default());
  }
}

@JS('find')
external dynamic _find([String name]);

@JS('getDefault')
external dynamic _default();
