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
  static Future<User> user() async {
    User user = User();

    try {
      Map<String, dynamic>? data = await SharedPreferencesHelper.getMap('user');
      user = User.fromJson(data);
      logg(data, color: LogColor.blue);
    } catch (e, s) {
      Errors.check(e, s);
    }
    return user;
  }

  /// ``` dart
  /// Function To set token to local storage
  /// await Auth.setToken('token');
  /// ```

  static Future<bool> isLogged() async {
    String? token = prefs.getString('token');
    bool isLoggedIn = token != null;

    logg('Is Logged In: $isLoggedIn', name: 'Is Logged In');

    if (isLoggedIn) {
      // set token to Dio
      dio.options.headers['authorization'] = 'Bearer $token';
    }

    return isLoggedIn;
  }
}
