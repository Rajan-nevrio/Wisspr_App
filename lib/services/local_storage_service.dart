import 'package:shared_preferences/shared_preferences.dart';

/// A service class for managing local storage operations using SharedPreferences.
/// Provides type-safe methods for storing and retrieving string, int, double, and bool values.
class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _prefs;

  // Private constructor for singleton pattern
  LocalStorageService._();

  /// Get the singleton instance of LocalStorageService
  static LocalStorageService get instance {
    _instance ??= LocalStorageService._();
    return _instance!;
  }

  /// Initialize the SharedPreferences instance
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Get the SharedPreferences instance
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('LocalStorageService not initialized. Call LocalStorageService.init() first.');
    }
    return _prefs!;
  }

  // String operations
  /// Save a string value to local storage
  Future<bool> saveString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  /// Get a string value from local storage
  String? getString(String key) {
    return prefs.getString(key);
  }

  /// Get a string value with a default fallback
  String getStringOrDefault(String key, String defaultValue) {
    return prefs.getString(key) ?? defaultValue;
  }

  // Int operations
  /// Save an integer value to local storage
  Future<bool> saveInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  /// Get an integer value from local storage
  int? getInt(String key) {
    return prefs.getInt(key);
  }

  /// Get an integer value with a default fallback
  int getIntOrDefault(String key, int defaultValue) {
    return prefs.getInt(key) ?? defaultValue;
  }

  // Double operations
  /// Save a double value to local storage
  Future<bool> saveDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  /// Get a double value from local storage
  double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  /// Get a double value with a default fallback
  double getDoubleOrDefault(String key, double defaultValue) {
    return prefs.getDouble(key) ?? defaultValue;
  }

  // Bool operations
  /// Save a boolean value to local storage
  Future<bool> saveBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  /// Get a boolean value from local storage
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  /// Get a boolean value with a default fallback
  bool getBoolOrDefault(String key, bool defaultValue) {
    return prefs.getBool(key) ?? defaultValue;
  }

  // List operations
  /// Save a list of strings to local storage
  Future<bool> saveStringList(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }

  /// Get a list of strings from local storage
  List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  /// Get a list of strings with a default fallback
  List<String> getStringListOrDefault(String key, List<String> defaultValue) {
    return prefs.getStringList(key) ?? defaultValue;
  }

  // Utility operations
  /// Check if a key exists in local storage
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  /// Remove a specific key from local storage
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  /// Clear all data from local storage
  Future<bool> clear() async {
    return await prefs.clear();
  }

  /// Get all keys from local storage
  Set<String> getKeys() {
    return prefs.getKeys();
  }

  /// Reload the SharedPreferences instance
  Future<void> reload() async {
    await prefs.reload();
  }

  // Convenience methods for common use cases
  /// Save user preferences (commonly used data types)
  Future<bool> saveUserPreferences({
    String? name,
    int? age,
    double? height,
    bool? isDarkMode,
    List<String>? favoriteItems,
  }) async {
    bool success = true;
    
    if (name != null) {
      success &= await saveString('user_name', name);
    }
    if (age != null) {
      success &= await saveInt('user_age', age);
    }
    if (height != null) {
      success &= await saveDouble('user_height', height);
    }
    if (isDarkMode != null) {
      success &= await saveBool('is_dark_mode', isDarkMode);
    }
    if (favoriteItems != null) {
      success &= await saveStringList('favorite_items', favoriteItems);
    }
    
    return success;
  }

  /// Get user preferences
  Map<String, dynamic> getUserPreferences() {
    return {
      'name': getString('user_name'),
      'age': getInt('user_age'),
      'height': getDouble('user_height'),
      'isDarkMode': getBool('is_dark_mode'),
      'favoriteItems': getStringList('favorite_items'),
    };
  }

  /// Save app settings
  Future<bool> saveAppSettings({
    String? language,
    int? fontSize,
    double? volume,
    bool? notificationsEnabled,
  }) async {
    bool success = true;
    
    if (language != null) {
      success &= await saveString('app_language', language);
    }
    if (fontSize != null) {
      success &= await saveInt('app_font_size', fontSize);
    }
    if (volume != null) {
      success &= await saveDouble('app_volume', volume);
    }
    if (notificationsEnabled != null) {
      success &= await saveBool('notifications_enabled', notificationsEnabled);
    }
    
    return success;
  }

  /// Get app settings
  Map<String, dynamic> getAppSettings() {
    return {
      'language': getStringOrDefault('app_language', 'en'),
      'fontSize': getIntOrDefault('app_font_size', 16),
      'volume': getDoubleOrDefault('app_volume', 0.5),
      'notificationsEnabled': getBoolOrDefault('notifications_enabled', true),
    };
  }
}
