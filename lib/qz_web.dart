import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:qz/src/qz_lib.dart';

import 'qz_platform_interface.dart';

/// A web implementation of the QzPlatform of the Qz plugin.
class QzWeb extends QzPlatform {
  /// Constructs a QzWeb
  QzWeb();

  static void registerWith(Registrar registrar) {
    QzPlatform.instance = QzWeb();
  }

  @override
  String getQzVersion() => Qz().version;

  @override
  Future<dynamic> connect() => Qz().websocket.connect();

  @override
  Future<dynamic> print(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      Qz().printQz(
          printerName: printerName, base64: base64, blob: blob, uri: uri);

  @override
  Future<List<String>> getAllPrinters() => Qz().printers.findAll();
}
