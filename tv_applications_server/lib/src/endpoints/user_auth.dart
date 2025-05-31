


import 'package:serverpod/protocol.dart';
import 'package:serverpod/server.dart';
import 'package:serverpod_auth_server/module.dart';

class UserManager extends Endpoint{

  Future<bool> isSignIn(Session session) async {
    var isSignedIn = await session.isUserSignedIn;


    return isSignedIn;
  }
   Future<UserInfo?> getUserInfo(Session session, String email) async {

    // final authenticationInfo = await session.authenticated;
    // final userId = authenticationInfo?.userId;
    final user =  await Users.findUserByEmail(session, email);
    if( user != null) {
      return user;
    }

    return user;

  }
  Future<bool> updateScopeWithAdmin(Session session, int targetUserId) async {

    // final authenticationInfo = await session.authenticated;
    // final userId = authenticationInfo?.userId;
    print("User ID: $targetUserId");
    session.log("$targetUserId", level: LogLevel.info);
   final user =  await Users.updateUserScopes(session, targetUserId, {Scope.admin});
   if( user != null) {
     return true;
   }
    return false;

  }


}