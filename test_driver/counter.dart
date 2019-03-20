import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

import 'counter_main.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  runApp(IntegrationPage());
}
