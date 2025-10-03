import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wisspr_app/resources/local_storage.dart';
import '../../routes/navigation_helper.dart';

class SignUpProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  LocalStorage storage = LocalStorage();
  bool _isGoogleLoader = false;
  bool _isAppleLoader = false;

  bool get isGoogleLoader => _isGoogleLoader;
  bool get isAppleLoader => _isAppleLoader;

  /// Method used to google login.
  Future<User?> handleGoogleLogin() async {
    if(_isGoogleLoader || _isAppleLoader) return null;

    _isGoogleLoader = true;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await storage.saveAccessToken(googleAuth.accessToken ?? "");
      debugPrint('User Access token:-----> ${googleAuth.accessToken ?? ""}');

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;

    } catch (error) {
      debugPrint('Failed to Google login:-----> $error');
      return null;
    } finally {
      _isGoogleLoader = false;
      notifyListeners();
    }
  }

  /// Method used to apple login.
  Future<void> handleAppleLogin(BuildContext context) async {
    if(_isAppleLoader || _isGoogleLoader) return;

    _isAppleLoader = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('------> Apple login pressed');
      await storage.saveAccessToken("user_access_token");

      if (context.mounted) {
        NavigationHelper.goToHome(context);
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
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}