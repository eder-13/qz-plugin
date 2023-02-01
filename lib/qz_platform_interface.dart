import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qz/qz_web.dart';

abstract class QzPlatform extends PlatformInterface {
  /// Constructs a QzPlatform.
  QzPlatform() : super(token: _token);

  static final Object _token = Object();

  static QzPlatform _instance = QzWeb();

  /// The default instance of [QzPlatform] to use.
  ///
  /// Defaults to [MethodChannelQz].
  static QzPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QzPlatform] when
  /// they register themselves.
  static set instance(QzPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  String getQzVersion() {
    throw UnimplementedError('getQzVersion() has not been implemented.');
  }

  Future<dynamic> print(
      {String? printerName, String? base64, List<int>? blob, Uri? uri}) {
    throw UnimplementedError('print() has not been implemented.');
  }

  Future<List<String>> getAllPrinters() {
    throw UnimplementedError('getAllPrinters() has not been implemented.');
  }

  Future<dynamic> connect() {
    throw UnimplementedError('connect() has not been implemented.');
  }
}
