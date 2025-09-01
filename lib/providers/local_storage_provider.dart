import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service.dart';

/// Provider for LocalStorageService singleton instance
final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService.instance;
});

/// Provider for user preferences stored in local storage
final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  final localStorage = ref.watch(localStorageProvider);
  return UserPreferencesNotifier(localStorage);
});

/// Provider for app settings stored in local storage
final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  final localStorage = ref.watch(localStorageProvider);
  return AppSettingsNotifier(localStorage);
});

/// User preferences data model
class UserPreferences {
  final String? name;
  final int? age;
  final double? height;
  final bool isDarkMode;
  final List<String> favoriteItems;

  const UserPreferences({
    this.name,
    this.age,
    this.height,
    this.isDarkMode = false,
    this.favoriteItems = const [],
  });

  UserPreferences copyWith({
    String? name,
    int? age,
    double? height,
    bool? isDarkMode,
    List<String>? favoriteItems,
  }) {
    return UserPreferences(
      name: name ?? this.name,
      age: age ?? this.age,
      height: height ?? this.height,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      favoriteItems: favoriteItems ?? this.favoriteItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'height': height,
      'isDarkMode': isDarkMode,
      'favoriteItems': favoriteItems,
    };
  }

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      name: map['name'],
      age: map['age'],
      height: map['height'],
      isDarkMode: map['isDarkMode'] ?? false,
      favoriteItems: List<String>.from(map['favoriteItems'] ?? []),
    );
  }
}

/// App settings data model
class AppSettings {
  final String language;
  final int fontSize;
  final double volume;
  final bool notificationsEnabled;

  const AppSettings({
    this.language = 'en',
    this.fontSize = 16,
    this.volume = 0.5,
    this.notificationsEnabled = true,
  });

  AppSettings copyWith({
    String? language,
    int? fontSize,
    double? volume,
    bool? notificationsEnabled,
  }) {
    return AppSettings(
      language: language ?? this.language,
      fontSize: fontSize ?? this.fontSize,
      volume: volume ?? this.volume,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'fontSize': fontSize,
      'volume': volume,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      language: map['language'] ?? 'en',
      fontSize: map['fontSize'] ?? 16,
      volume: map['volume'] ?? 0.5,
      notificationsEnabled: map['notificationsEnabled'] ?? true,
    );
  }
}

/// StateNotifier for managing user preferences
class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  final LocalStorageService _localStorage;

  UserPreferencesNotifier(this._localStorage) : super(const UserPreferences()) {
    _loadPreferences();
  }

  /// Load user preferences from local storage
  void _loadPreferences() {
    final prefs = _localStorage.getUserPreferences();
    state = UserPreferences.fromMap(prefs);
  }

  /// Update user name
  Future<void> updateName(String name) async {
    await _localStorage.saveString('user_name', name);
    state = state.copyWith(name: name);
  }

  /// Update user age
  Future<void> updateAge(int age) async {
    await _localStorage.saveInt('user_age', age);
    state = state.copyWith(age: age);
  }

  /// Update user height
  Future<void> updateHeight(double height) async {
    await _localStorage.saveDouble('user_height', height);
    state = state.copyWith(height: height);
  }

  /// Toggle dark mode
  Future<void> toggleDarkMode() async {
    final newValue = !state.isDarkMode;
    await _localStorage.saveBool('is_dark_mode', newValue);
    state = state.copyWith(isDarkMode: newValue);
  }

  /// Add favorite item
  Future<void> addFavoriteItem(String item) async {
    final newFavorites = List<String>.from(state.favoriteItems)..add(item);
    await _localStorage.saveStringList('favorite_items', newFavorites);
    state = state.copyWith(favoriteItems: newFavorites);
  }

  /// Remove favorite item
  Future<void> removeFavoriteItem(String item) async {
    final newFavorites = List<String>.from(state.favoriteItems)..remove(item);
    await _localStorage.saveStringList('favorite_items', newFavorites);
    state = state.copyWith(favoriteItems: newFavorites);
  }

  /// Clear all user preferences
  Future<void> clearPreferences() async {
    await _localStorage.remove('user_name');
    await _localStorage.remove('user_age');
    await _localStorage.remove('user_height');
    await _localStorage.remove('is_dark_mode');
    await _localStorage.remove('favorite_items');
    state = const UserPreferences();
  }
}

/// StateNotifier for managing app settings
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  final LocalStorageService _localStorage;

  AppSettingsNotifier(this._localStorage) : super(const AppSettings()) {
    _loadSettings();
  }

  /// Load app settings from local storage
  void _loadSettings() {
    final settings = _localStorage.getAppSettings();
    state = AppSettings.fromMap(settings);
  }

  /// Update language setting
  Future<void> updateLanguage(String language) async {
    await _localStorage.saveString('app_language', language);
    state = state.copyWith(language: language);
  }

  /// Update font size setting
  Future<void> updateFontSize(int fontSize) async {
    await _localStorage.saveInt('app_font_size', fontSize);
    state = state.copyWith(fontSize: fontSize);
  }

  /// Update volume setting
  Future<void> updateVolume(double volume) async {
    await _localStorage.saveDouble('app_volume', volume);
    state = state.copyWith(volume: volume);
  }

  /// Toggle notifications
  Future<void> toggleNotifications() async {
    final newValue = !state.notificationsEnabled;
    await _localStorage.saveBool('notifications_enabled', newValue);
    state = state.copyWith(notificationsEnabled: newValue);
  }

  /// Clear all app settings
  Future<void> clearSettings() async {
    await _localStorage.remove('app_language');
    await _localStorage.remove('app_font_size');
    await _localStorage.remove('app_volume');
    await _localStorage.remove('notifications_enabled');
    state = const AppSettings();
  }
}
