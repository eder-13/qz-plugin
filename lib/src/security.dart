@JS('enableQzSecurity')
library qz_security;

import 'package:js/js.dart';
import 'dart:js_util';

class QzSecurity {

}

class EncodingAlgorithm {
  final String _value;
  const EncodingAlgorithm._internal(this._value);
  @override
  toString() => _value;

  static const sha1 = EncodingAlgorithm._internal('SHA1');
  static const sha256 = EncodingAlgorithm._internal('SHA256');
  static const sha512 = EncodingAlgorithm._internal('SHA512');
}

