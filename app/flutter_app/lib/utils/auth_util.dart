
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtil {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static SharedPreferences _sharedPreferences;
  static int currentId = 0;

  static void getCurrentUser() async{
    _sharedPreferences = await _prefs;
    currentId = _sharedPreferences.get("current");
  }
  static int getCurrent () {
    getCurrentUser();
    return currentId;
  }
}