import 'package:flutter/material.dart';
import 'package:tv_application_admin/main.dart';
import 'package:tv_applications_client/tv_applications_client.dart';

class AdminUsersProvider extends ChangeNotifier {
  List<UserInfo> _users = [];
  bool _isLoading = false;
  String? _error;

  List<UserInfo> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await client.userAuthAdmin.listUsers();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 