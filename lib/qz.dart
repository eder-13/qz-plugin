import 'qz_platform_interface.dart';

class Qz {
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
