class QzWeb {
  QzWeb(
      {bool backendMode = false,
      String algorithm = 'SHA512',
      String? certificateUrl,
      String? signatureUrl,
      String? certificateString,
      String? signatureString});

  String getQzVersion() => throw UnimplementedError('Unsupported');

  Future<dynamic> connect() => throw UnimplementedError('Unsupported');

  Future<void> reloadConnection() => throw UnimplementedError('Unsupported');

  Future<dynamic> print(
          {String? printerName, String? base64, List<int>? blob, Uri? uri}) =>
      throw UnimplementedError('Unsupported');

  Future<List<String>> getAllPrinters() =>
      throw UnimplementedError('Unsupported');

  Future<dynamic> printZpl({String? printerName, required String zplString}) =>
      throw UnimplementedError('Unsupported');
}
