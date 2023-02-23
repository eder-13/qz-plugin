@JS()
library qz_security;

import 'package:js/js.dart';
import 'package:qz/qz_web.dart';

class Qz {
  final QzWeb _instance = QzWeb();

  Qz(
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

  String getQzVersion() => _instance.getQzVersion();

  Future<dynamic> connect() => _instance.connect();

  Future<dynamic> print(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      _instance.print(
          printerName: printerName, base64: base64, blob: blob, uri: uri);

  Future<List<String>> getAllPrinters() => _instance.getAllPrinters();

  Future<dynamic> printZpl({String? printerName, required String zplString}) =>
      _instance.printZpl(zplString: zplString, printerName: printerName);
}

@JS('enableBackendSecurity')
external void _enableBackendSecurity(
    String certificateUrl, String algorithm, String signatureUrl);

@JS('enableFrontendSecurity')
external void _enableFrontendSecurity(
    String certificateString, String algorithm, String signatureString);
