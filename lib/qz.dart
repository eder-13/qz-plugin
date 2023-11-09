import 'package:qz/qz_stub.dart'
    if (dart.library.html) 'package:qz/qz_web.dart';

class Qz extends QzWeb {
  Qz(
      {super.backendMode,
      super.algorithm,
      super.certificateUrl,
      super.signatureUrl,
      super.certificateString,
      super.signatureString});
}
