import 'package:riverpod_example/app/data/local/shared_preferences.dart';

class IntroBanner {
  static Future<bool> setIntro(bool value) async {
    final _prefs = await SharedPreferencesHelper.instance;
    return await _prefs.setBool('introBannerShown', value);
  }

  static Future<bool> getIntro() async {
    final _pref = await SharedPreferencesHelper.instance;
    return await _pref.getBool('introBannerShown');
  }
}