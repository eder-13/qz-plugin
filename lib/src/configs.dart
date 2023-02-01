@JS('qz.configs')
library qz_configs;

import 'package:js/js.dart';

class QzConfigs {
  dynamic create(String printer) => _create(printer);
}

@JS('create')
external dynamic _create(String printer);
