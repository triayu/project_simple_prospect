import 'shared_preferences.dart';

class IntroBannerStorage {
  static Future<bool> checkShowBanner() async {
    // Cek apakah banner sudah pernah ditampilkan
    bool previouslyShown = await prefs.getBool('showBanner') ?? false;
    if (!previouslyShown) {
      // Tampilkan banner
      await prefs.setBool('showBanner', true);
      return true;
    } else {
      return false;
    }
  }
}
