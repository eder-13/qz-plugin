@JS('qz')
library qz;

import 'dart:convert';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:qz/src/configs.dart';
import 'package:qz/src/printers.dart';
import 'package:qz/src/websocket.dart';

class QzIo {
  static final QzWebsocket _websocket = QzWebsocket();
  static final QzPrinters _printers = QzPrinters();
  static final QzConfigs _configs = QzConfigs();

  static String get version => _version;

  static Future<dynamic> connect() => _websocket.connect();
  static Future<dynamic> disconnect() => _websocket.disconnect();
  static Future<void> reloadConnection() async {
    await disconnect();
    await connect();
  }

  static Future<List<String>> getAllPrinters() => _printers.findAll();

  static Future<void> print(
      {String? printerName, required List<dynamic> data}) async {
    try {
      String printer = printerName != null
          ? await _printers.findOne(printerName)
          : await _printers.getDefault();

      final config = _configs.create(printer);

      await _print(config, jsify(data));
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _smartPrint(
      {required String type,
      required String format,
      String? printerName,
      String? base64,
      List<int>? blob,
      Uri? uri}) async {
    assert(base64 != null || blob != null || uri != null);

    String flavor, data;

    if (base64 != null) {
      flavor = 'base64';
      data = base64;
    } else if (blob != null) {
      flavor = 'base64';
      data = base64Encode(blob);
    } else {
      flavor = 'file';
      data = uri.toString();
    }

    final info = [
      {
        'type': type,
        'format': format,
        'flavor': flavor,
        'data': data,
      }
    ];

    return print(data: info, printerName: printerName);
  }

  static Future<void> printRaw(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      _smartPrint(
        type: 'raw',
        format: 'command',
        printerName: printerName,
        base64: base64,
        blob: blob,
        uri: uri,
      );

  static Future<void> printPDF(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      _smartPrint(
        type: 'pixel',
        format: 'pdf',
        printerName: printerName,
        base64: base64,
        blob: blob,
        uri: uri,
      );

  static Future<void> printZPL({String? printerName, required String zpl}) =>
      print(data: [zpl], printerName: printerName);
}

@JS('version')
external String get _version;

@JS('print')
external dynamic _print(dynamic config, dynamic data);
