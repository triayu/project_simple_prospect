import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/local/shared_preferences.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';
import '../models/model.dart';

class AuthStorage {
  /// ``` dart
  /// Function To Set User When Login
  /// await Auth.login();
  /// ```
  ///
  static User user() {
    User user = User();
    Map<String, dynamic>? data = SharedPreferencesHelper.getMap('user');
    user = User.fromJson(data);
    return user;
  }

  /// ``` dart
  /// Function To set token to local storage
  /// await Auth.setToken('token');
  /// ```

  static Future<bool> isLogged() async {
    String? token = await prefs.getString('token');
    bool isLoggedIn = token != null;

    if (isLoggedIn) {
      // set token to Dio
      logg('Bearer $token', name: 'Token', color: LogColor.red);
      dio.options.headers['authorization'] = 'Bearer $token';
    }

    return isLoggedIn;
  }
}
