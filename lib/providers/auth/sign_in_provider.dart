import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wisspr_app/common_methods/common_methods.dart';
import 'package:wisspr_app/resources/local_storage.dart';
import '../../commom_widgets/customer_text/marcellus_font_type_text.dart';
import '../../response_models/login_model.dart';
import '../../routes/navigation_helper.dart';
import '../../services/api_service.dart';
import '../../services/api_url.dart';

class SignUpProvider with ChangeNotifier {
  static final ApiService _apiService = ApiService(timeout: const Duration(seconds: 10));
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "911530643581-obue9sqajl2389q6m8e4ojve0i8ui4i4.apps.googleusercontent.com",
    serverClientId: "911530643581-mfkuigpn597v93t2bhaa5ksvbeba2opi.apps.googleusercontent.com",
    scopes: <String>['email', 'profile'],
  );
  CommonMethods commonMethods = CommonMethods();
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
  Future<void> handleGoogleLogin(BuildContext context) async {
    if(_isGoogleLoader || _isAppleLoader) return;

    _isGoogleLoader = true;
    notifyListeners();

    try {
      final isAvailable = await _googleSignIn.isSignedIn();
      debugPrint('Google Sign-In available:-----> $isAvailable');
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('------> Google Sign-In cancelled by user');
        return;
      }

      debugPrint('Google Sign-In successful for user:------> ${googleUser.email}');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      _idToken = googleAuth.idToken ?? "";
      _accessToken = googleAuth.accessToken ?? "";
      _userEmail = googleUser.email;
      _userName = googleUser.displayName ?? "";
      _userPhotoUrl = googleUser.photoUrl ?? "";
      
      debugPrint('User id token:-----> $_idToken');
      debugPrint('User Access token:-----> $_accessToken');
      debugPrint('User Email:-----> $_userEmail');
      debugPrint('User Name:-----> $_userName');

      final LoginModel? loginResult = await socialLogin(provider: 'google');
      
      if (loginResult != null && loginResult.status == true) {
        _isLoggedIn = true;
        await storage.saveAccessToken(loginResult.token ?? "");
        await storage.saveUserName(loginResult.user?.fullName ?? "");
        await storage.saveUserEmail(loginResult.user?.email ?? "");
        debugPrint("User Access Token:-----> ${storage.getAccessToken()}");

        if (context.mounted) {
          NavigationHelper.goToHome(context);
        }
      } else {
        debugPrint('Backend login failed:-----> $loginResult');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: MText(
                msg: 'Google login failed. Please try again.',
                textColor: Theme.of(context).colorScheme.primary,
                textWeight:  FontWeight.w400,
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
              duration: const Duration(seconds: 3),
            )
          );
        }
      }
    } catch (error) {
      debugPrint('Failed to Google login:-----> $error');
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
        debugPrint('----> Apple Sign-In is not available on this device');
        return;
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      _idToken = credential.identityToken ?? "";
      _accessToken = "";
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

      LoginModel? loginResult = await socialLogin(provider: 'apple');

      if (loginResult != null && (loginResult.status ?? false)) {
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
      await storage.clearAllDetails();
      await storage.clearAppleTokens();
      
      notifyListeners();
      debugPrint('User signed out successfully');
    } catch (error) {
      debugPrint('Failed to sign out:-----> $error');
    }
  }


  /// Method to handle social login with backend API
  Future<LoginModel?> socialLogin({required String provider}) async {
    LoginModel? response;
    String printResponse = "";
    Map<String, String> req = {
      "provider": provider,
      "platform": commonMethods.getPlatform(),
      "id_token": _idToken,
      "fcm_token": "",
    };

    try {
      final json = await _apiService.post(
        ApiUrl.socialLogin,
        body: req,
      );
      response = LoginModel.fromJson(json);
      printResponse = jsonEncode(json);
      return response;

    } catch (error) {
      debugPrint('Social login API error:-----> $error');
      return null;
    } finally {
      commonMethods.printPostResponse(url: ApiUrl.socialLogin, requestBody: req, response: printResponse);
    }
  }
}