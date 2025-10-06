import '../utils/shared_preferences_helper.dart';

class LocalStorage{

  /// Method used to save user access token.
  Future<void> saveGoogleAccessToken(String token) async {
    await SharedPreferencesHelper.saveString(StorageKey.googleAccessToken, token);
  }

  /// Method used to get user access token.
  Future<String> getGoogleAccessToken() async {
    return await SharedPreferencesHelper.getString(StorageKey.googleAccessToken) ?? "";
  }

  /// Method used to remove user access token.
  Future<void> removeGoogleAccessToken() async {
    await SharedPreferencesHelper.removeString(StorageKey.googleAccessToken);
  }

  /// Method used to save Google ID token.
  Future<void> saveGoogleIdToken(String token) async {
    await SharedPreferencesHelper.saveString(StorageKey.googleIdToken, token);
  }

  /// Method used to get Google ID token.
  Future<String> getGoogleIdToken() async {
    return await SharedPreferencesHelper.getString(StorageKey.googleIdToken) ?? "";
  }

  /// Method used to remove Google ID token.
  Future<void> removeGoogleIdToken() async {
    await SharedPreferencesHelper.removeString(StorageKey.googleIdToken);
  }

  /// Method used to clear all Google tokens.
  Future<void> clearGoogleTokens() async {
    await removeGoogleAccessToken();
    await removeGoogleIdToken();
  }

  /// Method used to save Apple ID token.
  Future<void> saveAppleIdToken(String token) async {
    await SharedPreferencesHelper.saveString(StorageKey.appleIdToken, token);
  }

  /// Method used to get Apple ID token.
  Future<String> getAppleIdToken() async {
    return await SharedPreferencesHelper.getString(StorageKey.appleIdToken) ?? "";
  }

  /// Method used to remove Apple ID token.
  Future<void> removeAppleIdToken() async {
    await SharedPreferencesHelper.removeString(StorageKey.appleIdToken);
  }

  /// Method used to clear all Apple tokens.
  Future<void> clearAppleTokens() async {
    await removeAppleIdToken();
  }
}

class StorageKey{
  static String googleAccessToken = "google_access_token";
  static String googleIdToken = "google_id_token";
  static String appleIdToken = "apple_id_token";
}