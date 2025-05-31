

import 'package:serverpod/server.dart';
import 'package:serverpod_auth_server/module.dart';

class UserAuthAdmin extends Endpoint {
  // This class can be used to manage user authentication for admin users.
  // It can include methods for login, logout, and checking authentication status.
    @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope.admin};
  // Example method to simulate admin login
 




  Future<List<UserInfo>> listUsers(Session session) async {
    final users = await UserInfo.db.find(session);

    return users;
  }
  Future<UserInfo?> getUserById(Session session, int userId) async {
    final user = await UserInfo.db.findById(session, userId);
    return user;
  }


  Future<void> blockUser(Session session, int userId) async {
    await Users.blockUser(session, userId);
  }

  Future<void> unblockUser(Session session, int userId) async {
    await Users.unblockUser(session, userId);
  }

  // Example method to simulate admin logout
  void logout() {
    // Logic for admin logout
    print('Admin logged out successfully.');
  }
}