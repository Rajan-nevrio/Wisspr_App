import '../utils/shared_preferences_helper.dart';

class LocalStorage{

  /// Method used to save user access token.
  Future<void> saveAccessToken(String token) async {
    await SharedPreferencesHelper.saveString(StorageKey.accessToken, token);
  }

  /// Method used to get user access token.
  Future<String> getAccessToken() async {
    return await SharedPreferencesHelper.getString(StorageKey.accessToken) ?? "";
  }

  /// Method used to remove user access token.
  Future<void> removeAccessToken() async {
    await SharedPreferencesHelper.removeString(StorageKey.accessToken);
  }

  /// Method used to save user name.
  Future<void> saveUserName(String token) async {
    await SharedPreferencesHelper.saveString(StorageKey.userName, token);
  }

  /// Method used to get user name.
  Future<String> getUserName() async {
    return await SharedPreferencesHelper.getString(StorageKey.userName) ?? "";
  }

  /// Method used to remove user name.
  Future<void> removeUserName() async {
    await SharedPreferencesHelper.removeString(StorageKey.userName);
  }

  /// Method used to save user name.
  Future<void> saveUserEmail(String token) async {
    await SharedPreferencesHelper.saveString(StorageKey.userEmail, token);
  }

  /// Method used to get user name.
  Future<String> getUserEmail() async {
    return await SharedPreferencesHelper.getString(StorageKey.userEmail) ?? "";
  }

  /// Method used to remove user name.
  Future<void> removeUserEmail() async {
    await SharedPreferencesHelper.removeString(StorageKey.userEmail);
  }

  /// Method used to clear all Google tokens.
  Future<void> clearAllDetails() async {
    await removeAccessToken();
    await removeUserName();
    await removeUserEmail();
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
  static String accessToken = "access_token";
  static String userName = "user_name";
  static String userEmail = "user_email";
  static String appleIdToken = "apple_id_token";
}