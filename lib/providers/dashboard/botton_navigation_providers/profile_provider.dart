import 'package:flutter/material.dart';
import 'package:wisspr_app/resources/local_storage.dart';
import 'package:wisspr_app/routes/navigation_helper.dart';

class ProfileProvider with ChangeNotifier {
  final LocalStorage _storage = LocalStorage();
  bool _isLogoutLoading = false;
  bool _isDeleteLoading = false;

  /// Getter to return the loaders value.
  bool get isLogoutLoading => _isLogoutLoading;
  bool get isDeleteLoading => _isDeleteLoading;

  /// Method used to logout the user.
  Future<void> logout(BuildContext context) async {
    if (_isLogoutLoading) return;
    _isLogoutLoading = true;
    notifyListeners();
    try {
      await _storage.removeGoogleAccessToken();
      if (context.mounted) {
        NavigationHelper.logout(context);
      }
    } catch (e) {
      debugPrint('Logout failed:------> $e');
    } finally {
      _isLogoutLoading = false;
      notifyListeners();
    }
  }

  /// Method used to delete user account.
  Future<void> deleteAccount(BuildContext context) async {
    if (_isDeleteLoading) return;
    _isDeleteLoading = true;
    notifyListeners();
    try {
      await _storage.removeGoogleAccessToken();
      if (context.mounted) {
        NavigationHelper.logout(context);
      }
    } catch (e) {
      debugPrint('Delete account failed:-----> $e');
    } finally {
      _isDeleteLoading = false;
      notifyListeners();
    }
  }
}


