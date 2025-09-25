import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => _instance;
  SharedPreferencesHelper._internal();

  static SharedPreferences? _prefs;
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  static Future<SharedPreferences> get _preferences async {
    if (!_isInitialized) {
      await init();
    }
    return _prefs!;
  }

  /// User related keys
  static const String _keyUserId = 'user_id';

  /// ========================================
  /// STRING METHODS
  /// ========================================

  static Future<bool> saveString(String key, String value) async {
    final prefs = await _preferences;
    return await prefs.setString(key, value);
  }

  static Future<String?> getString(String key, {String? defaultValue}) async {
    final prefs = await _preferences;
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<bool> removeString(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  /// ========================================
  /// BOOLEAN METHODS
  /// ========================================

  static Future<bool> saveBool(String key, bool value) async {
    final prefs = await _preferences;
    return await prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final prefs = await _preferences;
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> removeBool(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  /// ========================================
  /// INTEGER METHODS
  /// ========================================

  static Future<bool> saveInt(String key, int value) async {
    final prefs = await _preferences;
    return await prefs.setInt(key, value);
  }

  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    final prefs = await _preferences;
    return prefs.getInt(key) ?? defaultValue;
  }

  static Future<bool> removeInt(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  /// ========================================
  /// DOUBLE METHODS
  /// ========================================

  static Future<bool> saveDouble(String key, double value) async {
    final prefs = await _preferences;
    return await prefs.setDouble(key, value);
  }

  static Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    final prefs = await _preferences;
    return prefs.getDouble(key) ?? defaultValue;
  }

  static Future<bool> removeDouble(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  /// ========================================
  /// DYNAMIC/JSON METHODS
  /// ========================================

  static Future<bool> saveDynamic(String key, dynamic value) async {
    final prefs = await _preferences;
    if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    } else if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return await prefs.setStringList(key, value);
    } else {
      /// For complex objects, convert to JSON string.
      try {
        final jsonString = value.toString();
        return await prefs.setString(key, jsonString);
      } catch (e) {
        return false;
      }
    }
  }

  static Future<dynamic> getDynamic(String key, {dynamic defaultValue}) async {
    final prefs = await _preferences;
    return prefs.get(key) ?? defaultValue;
  }

  static Future<bool> removeDynamic(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  /// ========================================
  /// LIST METHODS
  /// ========================================

  static Future<bool> saveStringList(String key, List<String> value) async {
    final prefs = await _preferences;
    return await prefs.setStringList(key, value);
  }

  static Future<List<String>> getStringList(String key, {List<String>? defaultValue}) async {
    final prefs = await _preferences;
    return prefs.getStringList(key) ?? defaultValue ?? [];
  }

  static Future<bool> removeStringList(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  /// ========================================
  /// CONVENIENCE METHODS FOR PREDEFINED KEYS
  /// ========================================

  /// User related methods
  static Future<bool> saveUserId(String userId) => saveString(_keyUserId, userId);
  static Future<String?> getUserId() => getString(_keyUserId);
  static Future<bool> removeUserId() => removeString(_keyUserId);

  /// ========================================
  /// UTILITY METHODS
  /// ========================================

  /// Check if key exists
  static Future<bool> containsKey(String key) async {
    final prefs = await _preferences;
    return prefs.containsKey(key);
  }

  /// Get all keys
  static Future<Set<String>> getAllKeys() async {
    final prefs = await _preferences;
    return prefs.getKeys();
  }

  /// Clear all data
  static Future<bool> clearAll() async {
    final prefs = await _preferences;
    return await prefs.clear();
  }

  /// Clear specific keys
  static Future<bool> clearKeys(List<String> keys) async {
    final prefs = await _preferences;
    bool success = true;
    for (String key in keys) {
      success = success && await prefs.remove(key);
    }
    return success;
  }

  /// Get all data as Map
  static Future<Map<String, dynamic>> getAllData() async {
    final prefs = await _preferences;
    final keys = prefs.getKeys();
    final Map<String, dynamic> data = {};
    
    for (String key in keys) {
      data[key] = prefs.get(key);
    }
    
    return data;
  }

  /// Save multiple values at once
  static Future<bool> saveMultiple(Map<String, dynamic> data) async {
    final prefs = await _preferences;
    bool success = true;
    
    for (String key in data.keys) {
      final value = data[key];
      if (value is String) {
        success = success && await prefs.setString(key, value);
      } else if (value is bool) {
        success = success && await prefs.setBool(key, value);
      } else if (value is int) {
        success = success && await prefs.setInt(key, value);
      } else if (value is double) {
        success = success && await prefs.setDouble(key, value);
      } else if (value is List<String>) {
        success = success && await prefs.setStringList(key, value);
      }
    }
    
    return success;
  }
}


