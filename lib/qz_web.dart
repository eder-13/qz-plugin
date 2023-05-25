@JS()
library qz_security;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:qz/src/qz_lib.dart';

class QzWeb {
  QzWeb(
      {bool backendMode = false,
      String algorithm = 'SHA512',
      String? certificateUrl,
      String? signatureUrl,
      String? certificateString,
      String? signatureString}) {
    if (backendMode) {
      assert(certificateUrl != null && signatureUrl != null);
      _enableBackendSecurity(certificateUrl!, algorithm, signatureUrl!);
    } else {
      assert(certificateString != null && signatureString != null);
      _enableFrontendSecurity(certificateString!, algorithm, signatureString!);
    }
  }

  static void registerWith(Registrar registrar) {}

  String getQzVersion() => QzIo().version;

  Future<dynamic> connect() => QzIo().websocket.connect();

  Future<void> reloadConnection() async {
    await QzIo().websocket.disconnect();
    await QzIo().websocket.connect();
  }

  Future<void> print(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      QzIo().printQz(
          printerName: printerName, base64: base64, blob: blob, uri: uri);

  Future<void> printZpl({String? printerName, required String zplString}) =>
      QzIo().printZplQz(zpl: zplString, printerName: printerName);

  Future<List<String>> getAllPrinters() => QzIo().printers.findAll();
}

@JS('enableBackendSecurity')
external void _enableBackendSecurity(
    String certificateUrl, String algorithm, String signatureUrl);

@JS('enableFrontendSecurity')
external void _enableFrontendSecurity(
    String certificateString, String algorithm, String signatureString);
