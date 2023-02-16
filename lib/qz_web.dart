import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:qz/src/qz_lib.dart';

/// A web implementation of the QzPlatform of the Qz plugin.
class QzWeb {
  /// Constructs a QzWeb
  QzWeb();

  static void registerWith(Registrar registrar) {
    QzWeb();
  }

  String getQzVersion() => Qz().version;

  Future<dynamic> connect() => Qz().websocket.connect();

  Future<dynamic> print(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      Qz().printQz(
          printerName: printerName, base64: base64, blob: blob, uri: uri);

  Future<List<String>> getAllPrinters() => Qz().printers.findAll();
}
