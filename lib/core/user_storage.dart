import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserName(String userName) async =>
      await _preferences?.setString('userName', userName);

  static String? getUserName() => _preferences?.getString('userName');

  static Future setEmail(String email) async =>
      await _preferences?.setString('email', email);

  static String? getEmail() => _preferences?.getString('email');

  static Future setToken(String token) async =>
      await _preferences?.setString('token', token);

  static String? getToken() => _preferences?.getString('token');


  static Future setIsLogged(bool isLogged) async =>
      await _preferences?.setBool('isLogged', isLogged);

  static bool? getIsLogged() => _preferences?.getBool('isLogged');
}
