@JS('qz')
library qz;

import 'dart:convert';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:qz/src/configs.dart';
import 'package:qz/src/printers.dart';
import 'package:qz/src/websocket.dart';

class Qz {
  static final Qz _qz = Qz._internal();
  factory Qz() => _qz;
  Qz._internal();

  final QzWebsocket websocket = QzWebsocket();
  final QzPrinters printers = QzPrinters();
  final QzConfigs configs = QzConfigs();

  String get version => _version;

  Future<dynamic> printQz(
      {String? printerName, String? base64, List<int>? blob, Uri? uri}) async {
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

    try {
      String printer = printerName != null
          ? await printers.findOne(printerName)
          : await printers.getDefault();

      final config = configs.create(printer);
      final info = [
        {
          'type': 'pixel',
          'format': 'pdf',
          'flavor': flavor,
          'data': data,
        }
      ];

      await _print(config, jsify(info));
    } catch (e) {
      throw Exception(e);
    }
  }
}

@JS('version')
external String get _version;

@JS('print')
external dynamic _print(dynamic config, dynamic data);

