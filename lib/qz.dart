@JS()
library qz_security;

import 'package:js/js.dart';
import 'qz_platform_interface.dart';

class Qz {

    Qz({
      bool secureMode = false,
      String? certificateUrl,
      String algorithm = 'SHA512',
      String? signatureUrl
    }){
      if (secureMode) {
        assert(certificateUrl != null && signatureUrl != null);
        _enableSecurity(certificateUrl!, algorithm, signatureUrl!);
      }
    }


  String getQzVersion() {
    return QzPlatform.instance.getQzVersion();
  }

  Future<dynamic> connect() {
    return QzPlatform.instance.connect();
  }

  Future<dynamic> print(
      {String? printerName, String? base64, List<int>? blob, Uri? uri}) {
    return QzPlatform.instance
        .print(printerName: printerName, base64: base64, blob: blob, uri: uri);
  }

  Future<List<String>> getAllPrinters() {
    return QzPlatform.instance.getAllPrinters();
  }
}

@JS('enableSecurity')
external void _enableSecurity(String certificateUrl, String algorithm, String signatureUrl);
