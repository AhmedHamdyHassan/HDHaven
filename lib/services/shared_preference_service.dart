import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _keyUserId = 'userId';

  SharedPreferencesService._privateConstructor();
  static final SharedPreferencesService instance =
      SharedPreferencesService._privateConstructor();

  Future<void> storeUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUserId, userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }
}
