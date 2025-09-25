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
}

class StorageKey{
  static String accessToken = "access_token";
}