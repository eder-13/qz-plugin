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

  String get version => QzIo.version;

  Future<dynamic> connect() => QzIo.connect();
  Future<dynamic> disconnect() => QzIo.connect();
  Future<void> reloadConnection() => QzIo.reloadConnection();

  Future<List<String>> getAllPrinters() => QzIo.getAllPrinters();

  Future<void> print({String? printerName, required List<dynamic> data}) =>
      QzIo.print(printerName: printerName, data: data);

  Future<void> printRaw(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      QzIo.printRaw(
          printerName: printerName, base64: base64, blob: blob, uri: uri);

  Future<void> printPDF(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      QzIo.printPDF(
          printerName: printerName, base64: base64, blob: blob, uri: uri);

  Future<void> printZPL({String? printerName, required String zpl}) =>
      QzIo.printZPL(zpl: zpl, printerName: printerName);
}

@JS('enableBackendSecurity')
external void _enableBackendSecurity(
    String certificateUrl, String algorithm, String signatureUrl);

@JS('enableFrontendSecurity')
external void _enableFrontendSecurity(
    String certificateString, String algorithm, String signatureString);
