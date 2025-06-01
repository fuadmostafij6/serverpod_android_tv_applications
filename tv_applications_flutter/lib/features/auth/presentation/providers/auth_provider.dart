import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:tv_applications_flutter/main.dart';


class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _userEmail;


  final authController = EmailAuthController(client.modules.auth);
  Future<bool> login(String email, String password) async {
    var user = await authController.signIn(email, password);
    if (user == null) {
      return false; // Login failed
    }
    else {
      await client.userManager.updateScopeWithAdmin(user.id!);

      notifyListeners();
      return true;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    // TODO: Implement actual registration logic with your backend
    // For now, we'll just simulate a successful registration
    final success = await authController.createAccountRequest(name, email, password);
    final user = await client.userManager.getUserInfo(email);




    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userEmail = null;

    // Clear auth state


    notifyListeners();
  }
Future<bool> checkEmailVerification(String email, String verificationCode ) async {
 final user =  await authController.validateAccount(email, verificationCode);

    if (user != null) {
      await client.userManager.updateScopeWithAdmin(user!.id!);
      _isAuthenticated = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> resendVerificationEmail(String email) async {


}
  Future<void> checkAuthState() async {

    notifyListeners();
  }
} 