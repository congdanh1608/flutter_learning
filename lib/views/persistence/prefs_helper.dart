import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _counter = 'counter';

  static Future<void> setCounter(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_counter, value);
  }

  static Future<int> getCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_counter) ?? 0;
  }
}
