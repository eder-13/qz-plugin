import 'package:qz/qz_stub.dart'
    if (dart.library.html) 'package:qz/qz_web.dart';

class Qz extends QzWeb {
  Qz(
      {bool backendMode = false,
      String algorithm = 'SHA512',
      String? certificateUrl,
      String? signatureUrl,
      String? certificateString,
      String? signatureString})
      : super(
            backendMode: backendMode,
            algorithm: algorithm,
            certificateUrl: certificateUrl,
            signatureUrl: signatureUrl,
            certificateString: certificateString,
            signatureString: signatureString);
}
