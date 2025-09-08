import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Singleton pattern to ensure single instance
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => _instance;
  SharedPreferencesHelper._internal();

  static SharedPreferences? _prefs;
  static bool _isInitialized = false;

  // Initialize SharedPreferences
  static Future<void> init() async {
    if (_isInitialized) return; // Avoid re-initialization
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  // Ensure SharedPreferences is initialized
  static Future<SharedPreferences> get _preferences async {
    if (!_isInitialized) {
      await init();
    }
    return _prefs!;
  }

  // ========================================
  // KEY DEFINITIONS
  // ========================================
  
  // User related keys
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyUserToken = 'user_token';
  static const String _keyUserProfileImage = 'user_profile_image';
  
  // App settings keys
  static const String _keyIsFirstLaunch = 'is_first_launch';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyIsDarkMode = 'is_dark_mode';
  static const String _keySelectedLanguage = 'selected_language';
  static const String _keySelectedTheme = 'selected_theme';
  static const String _keyNotificationsEnabled = 'notifications_enabled';
  static const String _keyBiometricEnabled = 'biometric_enabled';
  
  // App data keys
  static const String _keyAppVersion = 'app_version';
  static const String _keyLastSyncTime = 'last_sync_time';
  static const String _keyCacheExpiry = 'cache_expiry';
  static const String _keyApiBaseUrl = 'api_base_url';
  static const String _keyApiTimeout = 'api_timeout';
  
  // User preferences keys
  static const String _keyFontSize = 'font_size';
  static const String _keyVolumeLevel = 'volume_level';
  static const String _keyBrightness = 'brightness';
  static const String _keyAutoSave = 'auto_save';
  static const String _keyRememberMe = 'remember_me';
  
  // Custom data keys
  static const String _keyCustomString = 'custom_string';
  static const String _keyCustomBool = 'custom_bool';
  static const String _keyCustomInt = 'custom_int';
  static const String _keyCustomDouble = 'custom_double';
  static const String _keyCustomJson = 'custom_json';

  // ========================================
  // STRING METHODS
  // ========================================

  /// Save string value
  static Future<bool> saveString(String key, String value) async {
    final prefs = await _preferences;
    return await prefs.setString(key, value);
  }

  /// Get string value
  static Future<String?> getString(String key, {String? defaultValue}) async {
    final prefs = await _preferences;
    return prefs.getString(key) ?? defaultValue;
  }

  /// Remove string value
  static Future<bool> removeString(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  // ========================================
  // BOOLEAN METHODS
  // ========================================

  /// Save boolean value
  static Future<bool> saveBool(String key, bool value) async {
    final prefs = await _preferences;
    return await prefs.setBool(key, value);
  }

  /// Get boolean value
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final prefs = await _preferences;
    return prefs.getBool(key) ?? defaultValue;
  }

  /// Remove boolean value
  static Future<bool> removeBool(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  // ========================================
  // INTEGER METHODS
  // ========================================

  /// Save integer value
  static Future<bool> saveInt(String key, int value) async {
    final prefs = await _preferences;
    return await prefs.setInt(key, value);
  }

  /// Get integer value
  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    final prefs = await _preferences;
    return prefs.getInt(key) ?? defaultValue;
  }

  /// Remove integer value
  static Future<bool> removeInt(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  // ========================================
  // DOUBLE METHODS
  // ========================================

  /// Save double value
  static Future<bool> saveDouble(String key, double value) async {
    final prefs = await _preferences;
    return await prefs.setDouble(key, value);
  }

  /// Get double value
  static Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    final prefs = await _preferences;
    return prefs.getDouble(key) ?? defaultValue;
  }

  /// Remove double value
  static Future<bool> removeDouble(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  // ========================================
  // DYNAMIC/JSON METHODS
  // ========================================

  /// Save dynamic value (converts to JSON string)
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
      // For complex objects, convert to JSON string
      try {
        final jsonString = value.toString();
        return await prefs.setString(key, jsonString);
      } catch (e) {
        return false;
      }
    }
  }

  /// Get dynamic value
  static Future<dynamic> getDynamic(String key, {dynamic defaultValue}) async {
    final prefs = await _preferences;
    return prefs.get(key) ?? defaultValue;
  }

  /// Remove dynamic value
  static Future<bool> removeDynamic(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  // ========================================
  // LIST METHODS
  // ========================================

  /// Save string list
  static Future<bool> saveStringList(String key, List<String> value) async {
    final prefs = await _preferences;
    return await prefs.setStringList(key, value);
  }

  /// Get string list
  static Future<List<String>> getStringList(String key, {List<String>? defaultValue}) async {
    final prefs = await _preferences;
    return prefs.getStringList(key) ?? defaultValue ?? [];
  }

  /// Remove string list
  static Future<bool> removeStringList(String key) async {
    final prefs = await _preferences;
    return await prefs.remove(key);
  }

  // ========================================
  // CONVENIENCE METHODS FOR PREDEFINED KEYS
  // ========================================

  // User related methods
  static Future<bool> saveUserId(String userId) => saveString(_keyUserId, userId);
  static Future<String?> getUserId() => getString(_keyUserId);
  static Future<bool> removeUserId() => removeString(_keyUserId);

  static Future<bool> saveUserName(String userName) => saveString(_keyUserName, userName);
  static Future<String?> getUserName() => getString(_keyUserName);
  static Future<bool> removeUserName() => removeString(_keyUserName);

  static Future<bool> saveUserEmail(String userEmail) => saveString(_keyUserEmail, userEmail);
  static Future<String?> getUserEmail() => getString(_keyUserEmail);
  static Future<bool> removeUserEmail() => removeString(_keyUserEmail);

  static Future<bool> saveUserToken(String token) => saveString(_keyUserToken, token);
  static Future<String?> getUserToken() => getString(_keyUserToken);
  static Future<bool> removeUserToken() => removeString(_keyUserToken);

  // App settings methods
  static Future<bool> saveIsFirstLaunch(bool isFirstLaunch) => saveBool(_keyIsFirstLaunch, isFirstLaunch);
  static Future<bool> getIsFirstLaunch() => getBool(_keyIsFirstLaunch, defaultValue: true);
  static Future<bool> removeIsFirstLaunch() => removeBool(_keyIsFirstLaunch);

  static Future<bool> saveIsLoggedIn(bool isLoggedIn) => saveBool(_keyIsLoggedIn, isLoggedIn);
  static Future<bool> getIsLoggedIn() => getBool(_keyIsLoggedIn, defaultValue: false);
  static Future<bool> removeIsLoggedIn() => removeBool(_keyIsLoggedIn);

  static Future<bool> saveIsDarkMode(bool isDarkMode) => saveBool(_keyIsDarkMode, isDarkMode);
  static Future<bool> getIsDarkMode() => getBool(_keyIsDarkMode, defaultValue: false);
  static Future<bool> removeIsDarkMode() => removeBool(_keyIsDarkMode);

  static Future<bool> saveSelectedLanguage(String language) => saveString(_keySelectedLanguage, language);
  static Future<String?> getSelectedLanguage() => getString(_keySelectedLanguage, defaultValue: 'en');
  static Future<bool> removeSelectedLanguage() => removeString(_keySelectedLanguage);

  static Future<bool> saveSelectedTheme(String theme) => saveString(_keySelectedTheme, theme);
  static Future<String?> getSelectedTheme() => getString(_keySelectedTheme, defaultValue: 'light');
  static Future<bool> removeSelectedTheme() => removeString(_keySelectedTheme);

  static Future<bool> saveNotificationsEnabled(bool enabled) => saveBool(_keyNotificationsEnabled, enabled);
  static Future<bool> getNotificationsEnabled() => getBool(_keyNotificationsEnabled, defaultValue: true);
  static Future<bool> removeNotificationsEnabled() => removeBool(_keyNotificationsEnabled);

  // App data methods
  static Future<bool> saveAppVersion(String version) => saveString(_keyAppVersion, version);
  static Future<String?> getAppVersion() => getString(_keyAppVersion);
  static Future<bool> removeAppVersion() => removeString(_keyAppVersion);

  static Future<bool> saveLastSyncTime(int timestamp) => saveInt(_keyLastSyncTime, timestamp);
  static Future<int> getLastSyncTime() => getInt(_keyLastSyncTime, defaultValue: 0);
  static Future<bool> removeLastSyncTime() => removeInt(_keyLastSyncTime);

  static Future<bool> saveFontSize(double fontSize) => saveDouble(_keyFontSize, fontSize);
  static Future<double> getFontSize() => getDouble(_keyFontSize, defaultValue: 16.0);
  static Future<bool> removeFontSize() => removeDouble(_keyFontSize);

  static Future<bool> saveVolumeLevel(double volume) => saveDouble(_keyVolumeLevel, volume);
  static Future<double> getVolumeLevel() => getDouble(_keyVolumeLevel, defaultValue: 0.5);
  static Future<bool> removeVolumeLevel() => removeDouble(_keyVolumeLevel);

  // ========================================
  // UTILITY METHODS
  // ========================================

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

  // ========================================
  // DEBUG METHODS
  // ========================================

  /// Print all stored data (for debugging)
  static Future<void> printAllData() async {
    final data = await getAllData();
    debugPrint('=== SharedPreferences Data ===');
    data.forEach((key, value) {
      debugPrint('$key: $value (${value.runtimeType})');
    });
    debugPrint('==============================');
  }

  /// Get storage size info
  static Future<Map<String, int>> getStorageInfo() async {
    final data = await getAllData();
    int totalKeys = data.length;
    int stringCount = 0;
    int boolCount = 0;
    int intCount = 0;
    int doubleCount = 0;
    int listCount = 0;

    data.forEach((key, value) {
      if (value is String) {
        stringCount++;
      } else if (value is bool) {
        boolCount++;
      } else if (value is int) {
        intCount++;
      } else if (value is double) {
        doubleCount++;
      } else if (value is List) {
        listCount++;
      }
    });

    return {
      'totalKeys': totalKeys,
      'strings': stringCount,
      'booleans': boolCount,
      'integers': intCount,
      'doubles': doubleCount,
      'lists': listCount,
    };
  }
}
