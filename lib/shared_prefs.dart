import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  // More abstraction
  static const _kCounter = 'counter';

  static Future<bool> setCounter(int value) =>
      _instance.setInt(_kCounter, value);

  static int? getCounter() => _instance.getInt(_kCounter);

  static removeCounter() => _instance.remove(_kCounter);
}
