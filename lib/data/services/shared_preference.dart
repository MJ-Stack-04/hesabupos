
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final SharedPreference _instance = SharedPreference._internal();
  factory SharedPreference() => _instance;
  SharedPreference._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _keyToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserFirstName = 'user_first_name';
  static const String _keyUserLastName = 'user_last_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyBranchId = 'branch_id';
  static const String _keyBranchName = 'branch_name';

  void saveToken(String token) => _prefs.setString(_keyToken, token);
  String? getToken() => _prefs.getString(_keyToken);
  void removeToken() => _prefs.remove(_keyToken);

  void saveRefreshToken(String token) => _prefs.setString(_keyRefreshToken, token);
  String? getRefreshToken() => _prefs.getString(_keyRefreshToken);
  void removeRefreshToken() => _prefs.remove(_keyRefreshToken);

  void saveUserId(String id) => _prefs.setString(_keyUserId, id);
  String? getUserId() => _prefs.getString(_keyUserId);
  void removeUserId() => _prefs.remove(_keyUserId);

  void saveUserFirstName(String name) => _prefs.setString(_keyUserFirstName, name);
  String? getUserFirstName() => _prefs.getString(_keyUserFirstName);
  void removeUserFirstName() => _prefs.remove(_keyUserFirstName);

  void saveUserLastName(String name) => _prefs.setString(_keyUserLastName, name);
  String? getUserLastName() => _prefs.getString(_keyUserLastName);
  void removeUserLastName() => _prefs.remove(_keyUserLastName);

  void saveUserEmail(String email) => _prefs.setString(_keyUserEmail, email);
  String? getUserEmail() => _prefs.getString(_keyUserEmail);
  void removeUserEmail() => _prefs.remove(_keyUserEmail);

  void saveBranchId(String branchId) => _prefs.setString(_keyBranchId, branchId);
  String? getBranchId() => _prefs.getString(_keyBranchId);
  void removeBranchId() => _prefs.remove(_keyBranchId);

  void saveBranchName(String branchName) => _prefs.setString(_keyBranchName, branchName);
  String? getBranchName() => _prefs.getString(_keyBranchName);
  void removeBranchName() => _prefs.remove(_keyBranchName);

  void saveString(String key, String value) => _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);
  void removeKey(String key) => _prefs.remove(key);
  bool containsKey(String key) => _prefs.containsKey(key);

  void saveBool(String key, bool value) => _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);

  void saveInt(String key, int value) => _prefs.setInt(key, value);
  int? getInt(String key) => _prefs.getInt(key);

  void saveDouble(String key, double value) => _prefs.setDouble(key, value);
  double? getDouble(String key) => _prefs.getDouble(key);

  void saveStringList(String key, List<String> value) => _prefs.setStringList(key, value);
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  void clearAll() {
    removeToken();
    removeRefreshToken();
    removeUserId();
    removeUserFirstName();
    removeUserLastName();
    removeUserEmail();
    removeBranchId();
    removeBranchName();
  }

  void clearAllData() async {
    await _prefs.clear();
  }
}