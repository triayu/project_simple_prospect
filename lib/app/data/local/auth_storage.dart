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

  static bool isLogged() {
    String? token = prefs.getString('token');
    bool isLoggedIn = token != null;

    if (isLoggedIn) {
      dio.setToken(token);
    }

    return isLoggedIn;
  }
}
