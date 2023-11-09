class QzWeb {
  QzWeb(
      {bool backendMode = false,
      String algorithm = 'SHA512',
      String? certificateUrl,
      String? signatureUrl,
      String? certificateString,
      String? signatureString});

  String get version => throw UnimplementedError('Unsupported');

  Future<dynamic> connect() => throw UnimplementedError('Unsupported');
  Future<dynamic> disconnect() => throw UnimplementedError('Unsupported');
  Future<void> reloadConnection() => throw UnimplementedError('Unsupported');

  Future<List<String>> getAllPrinters() =>
      throw UnimplementedError('Unsupported');

  Future<dynamic> print({String? printerName, required List<dynamic> data}) =>
      throw UnimplementedError('Unsupported');

  Future<dynamic> printRaw(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      throw UnimplementedError('Unsupported');

  Future<dynamic> printPDF(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      throw UnimplementedError('Unsupported');

  Future<dynamic> printZPL({String? printerName, required String zpl}) =>
      throw UnimplementedError('Unsupported');
}
