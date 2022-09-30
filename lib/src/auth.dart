import 'package:shared_preferences/shared_preferences.dart';
import 'package:supper_app/supper_app.dart';

class User {
  String? accessToken;
  String? refreshToken;

  void saveToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', accessToken ?? '');
    pref.setString('refreshToken', refreshToken ?? '');
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('accessToken');
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('refreshToken');
  }
}

class Auth<T extends User> {
  factory Auth() {
    return _singleton as Auth<T>;
  }

  Auth._internal();
  static final Auth<User> _singleton = Auth<User>._internal();
  T? _user;

  void authenticate(T user) {
    _user = user;
    BusService.sendMessage(Message("user", user));
  }

  void unauthenticated() {
    _user = null;
    BusService.sendMessage(Message("user", null));
  }

  T? user() {
    return _user;
  }
}
