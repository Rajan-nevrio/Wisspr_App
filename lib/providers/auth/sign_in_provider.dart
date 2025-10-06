import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wisspr_app/resources/local_storage.dart';
import '../../routes/navigation_helper.dart';
import '../../services/api_service.dart';
import '../../services/api_url.dart';

class SignUpProvider with ChangeNotifier {
  static final ApiService _apiService = ApiService(timeout: const Duration(seconds: 10));
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "911530643581-mfkuigpn597v93t2bhaa5ksvbeba2opi.apps.googleusercontent.com",
    scopes: <String>['email', 'profile'],
  );
  LocalStorage storage = LocalStorage();
  String _idToken = "";
  String _accessToken = "";
  String _userEmail = "";
  String _userName = "";
  String _userPhotoUrl = "";
  bool _isGoogleLoader = false;
  bool _isAppleLoader = false;
  bool _isLoggedIn = false;

  String get idToken => _idToken;
  String get accessToken => _accessToken;
  String get userEmail => _userEmail;
  String get userName => _userName;
  String get userPhotoUrl => _userPhotoUrl;
  bool get isGoogleLoader => _isGoogleLoader;
  bool get isAppleLoader => _isAppleLoader;
  bool get isLoggedIn => _isLoggedIn;

  /// Method used to google login without Firebase.
  Future<Map<String, dynamic>?> handleGoogleLogin(BuildContext context) async {
    if(_isGoogleLoader || _isAppleLoader) return null;

    _isGoogleLoader = true;
    notifyListeners();

    try {
      final isAvailable = await _googleSignIn.isSignedIn();
      debugPrint('Google Sign-In available:-----> $isAvailable');
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('------> Google Sign-In cancelled by user');
        return null;
      }

      debugPrint('Google Sign-In successful for user:------> ${googleUser.email}');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      _idToken = googleAuth.idToken ?? "";
      _accessToken = googleAuth.accessToken ?? "";
      _userEmail = googleUser.email;
      _userName = googleUser.displayName ?? "";
      _userPhotoUrl = googleUser.photoUrl ?? "";

      await storage.saveGoogleAccessToken(_accessToken);
      await storage.saveGoogleIdToken(_idToken);
      
      debugPrint('User id token:-----> $_idToken');
      debugPrint('User Access token:-----> $_accessToken');
      debugPrint('User Email:-----> $_userEmail');
      debugPrint('User Name:-----> $_userName');

      final loginResult = await socialLogin(provider: 'google');
      
      if (loginResult != null && loginResult['success'] == true) {
        _isLoggedIn = true;
        return loginResult;
      } else {
        debugPrint('Backend login failed:-----> $loginResult');
        return null;
      }

    } catch (error) {
      debugPrint('Failed to Google login:-----> $error');
      return null;
    } finally {
      _isGoogleLoader = false;
      notifyListeners();
    }
  }

  /// Method used to apple login without Firebase.
  Future<void> handleAppleLogin(BuildContext context) async {
    if(_isAppleLoader || _isGoogleLoader) return;

    _isAppleLoader = true;
    notifyListeners();

    try {
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        debugPrint('Apple Sign-In is not available on this device');
        return;
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      _idToken = credential.identityToken ?? "";
      _accessToken = ""; // Apple flow here does not yield OAuth access token
      _userEmail = credential.email ?? _userEmail;
      final fullName = [
        credential.givenName,
        credential.familyName,
      ].where((e) => (e ?? '').isNotEmpty).join(' ');
      _userName = fullName.isNotEmpty ? fullName : _userName;

      if (_idToken.isEmpty) {
        debugPrint('Apple identity token missing');
        return;
      }

      await storage.saveAppleIdToken(_idToken);

      final loginResult = await socialLogin(provider: 'apple');

      if (loginResult != null && loginResult['success'] == true) {
        _isLoggedIn = true;
        if (context.mounted) {
          NavigationHelper.goToHome(context);
        }
      } else {
        debugPrint('Backend Apple login failed:-----> $loginResult');
      }
      
    } catch (error) {
      debugPrint('Failed to Apple login:-----> $error');
    } finally {
      _isAppleLoader = false;
      notifyListeners();
    }
  }

  /// Method used to google logout.
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _idToken = "";
      _accessToken = "";
      _userEmail = "";
      _userName = "";
      _userPhotoUrl = "";
      _isLoggedIn = false;
      await storage.clearGoogleTokens();
      await storage.clearAppleTokens();
      
      notifyListeners();
      debugPrint('User signed out successfully');
    } catch (error) {
      debugPrint('Failed to sign out:-----> $error');
    }
  }


  /// Method to handle social login with backend API
  Future<Map<String, dynamic>?> socialLogin({required String provider}) async {
    Map<String, String> req = {
      "provider": provider,
      "id_token": _idToken,
    };

    try {
      var response = await _apiService.post(
        ApiUrl.socialLogin,
        body: req,
      );
      return response;

    } catch (error) {
      debugPrint('Social login API error:-----> $error');
      return null;
    }
  }
}