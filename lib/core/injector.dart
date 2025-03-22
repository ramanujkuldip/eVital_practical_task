import 'package:shared_preferences/shared_preferences.dart';

import 'constants/pref_keys.dart';

class Injector {
  static Injector? _instance;

  static SharedPreferences? prefs;

  factory Injector() {
    return _instance ?? Injector._internal();
  }

  Injector._internal() {
    _instance = this;
  }

  static Injector get shared => Injector();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();
  }


  static bool get isLoggedIn => prefs?.getBool(PrefKeys.isLoggedIn) ?? false;

  static set isLoggedIn(value) => prefs?.setBool(PrefKeys.isLoggedIn, value);


}
