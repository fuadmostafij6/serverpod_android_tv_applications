

import 'package:serverpod/server.dart';
import 'package:serverpod_auth_server/module.dart';

class UserAuthAdmin extends Endpoint {
  // This class can be used to manage user authentication for admin users.
  // It can include methods for login, logout, and checking authentication status.

  // Example method to simulate admin login
  Future<UserInfo?> getUserInfo(Session session, String email) async {

    // final authenticationInfo = await session.authenticated;
    // final userId = authenticationInfo?.userId;
    final user =  await Users.findUserByEmail(session, email);
    if( user != null) {
      return user;
    }

    return user;

  }

  // Example method to simulate admin logout
  void logout() {
    // Logic for admin logout
    print('Admin logged out successfully.');
  }
}