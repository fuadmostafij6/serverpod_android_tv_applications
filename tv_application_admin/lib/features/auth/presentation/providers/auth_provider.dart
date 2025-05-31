import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:tv_application_admin/main.dart';


class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _userEmail;


  final authController = EmailAuthController(client.modules.auth);

  Future<bool> login(String email, String password) async {
    try {
      var userData = await client.userManager.getUserInfo(email);
      
      if (userData == null) {
        throw Exception('User not found');
      }

      if (!userData.scopeNames.contains("serverpod.admin")) {
        throw Exception('User does not have admin privileges');
      }

      var user = await authController.signIn(email, password);
      
      if (user == null) {
        throw Exception('Invalid email or password');
      }

      await client.userManager.updateScopeWithAdmin(user.id!);
      _isAuthenticated = true;
      _userEmail = email;
      notifyListeners();
      return true;
      
    } catch (e) {
      _isAuthenticated = false;
      _userEmail = null;
      notifyListeners();
      rethrow; // Rethrow the error to be handled by the UI
    }
  }

  Future<bool> register(String name, String email, String password) async {
    // TODO: Implement actual registration logic with your backend
    // For now, we'll just simulate a successful registration

    final success = await authController.createAccountRequest(name, email, password);


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