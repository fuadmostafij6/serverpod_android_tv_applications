/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:tv_applications_client/src/protocol/movie.dart' as _i3;
import 'package:tv_applications_client/src/protocol/media.dart' as _i4;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointMovie extends _i1.EndpointRef {
  EndpointMovie(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'movie';

  _i2.Future<void> createMovie(_i3.Movie movie) =>
      caller.callServerEndpoint<void>(
        'movie',
        'createMovie',
        {'movie': movie},
      );

  _i2.Future<void> deleteMovie(_i3.Movie movie) =>
      caller.callServerEndpoint<void>(
        'movie',
        'deleteMovie',
        {'movie': movie},
      );

  _i2.Future<void> updateMovie(_i3.Movie movie) =>
      caller.callServerEndpoint<void>(
        'movie',
        'updateMovie',
        {'movie': movie},
      );

  _i2.Future<List<_i3.Movie>> getAllMovie() =>
      caller.callServerEndpoint<List<_i3.Movie>>(
        'movie',
        'getAllMovie',
        {},
      );
}

/// {@category Endpoint}
class EndpointMedia extends _i1.EndpointRef {
  EndpointMedia(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'media';

  _i2.Future<void> createTv(_i4.Media tv) => caller.callServerEndpoint<void>(
        'media',
        'createTv',
        {'tv': tv},
      );

  _i2.Future<void> deleteTv(_i4.Media tv) => caller.callServerEndpoint<void>(
        'media',
        'deleteTv',
        {'tv': tv},
      );

  _i2.Future<void> updateTv(_i4.Media tv) => caller.callServerEndpoint<void>(
        'media',
        'updateTv',
        {'tv': tv},
      );

  _i2.Future<void> insertMediaList(List<_i4.Media> mediaList) =>
      caller.callServerEndpoint<void>(
        'media',
        'insertMediaList',
        {'mediaList': mediaList},
      );

  _i2.Future<List<_i4.Media>> getAllTv() =>
      caller.callServerEndpoint<List<_i4.Media>>(
        'media',
        'getAllTv',
        {},
      );
}

/// {@category Endpoint}
class EndpointUserManager extends _i1.EndpointRef {
  EndpointUserManager(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userManager';

  _i2.Future<bool> isSignIn() => caller.callServerEndpoint<bool>(
        'userManager',
        'isSignIn',
        {},
      );

  _i2.Future<_i5.UserInfo?> getUserInfo(String email) =>
      caller.callServerEndpoint<_i5.UserInfo?>(
        'userManager',
        'getUserInfo',
        {'email': email},
      );

  _i2.Future<bool> updateScopeWithAdmin(int targetUserId) =>
      caller.callServerEndpoint<bool>(
        'userManager',
        'updateScopeWithAdmin',
        {'targetUserId': targetUserId},
      );
}

/// {@category Endpoint}
class EndpointUserAuthAdmin extends _i1.EndpointRef {
  EndpointUserAuthAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userAuthAdmin';

  _i2.Future<List<_i5.UserInfo>> listUsers() =>
      caller.callServerEndpoint<List<_i5.UserInfo>>(
        'userAuthAdmin',
        'listUsers',
        {},
      );

  _i2.Future<_i5.UserInfo?> getUserById(int userId) =>
      caller.callServerEndpoint<_i5.UserInfo?>(
        'userAuthAdmin',
        'getUserById',
        {'userId': userId},
      );

  _i2.Future<void> blockUser(int userId) => caller.callServerEndpoint<void>(
        'userAuthAdmin',
        'blockUser',
        {'userId': userId},
      );

  _i2.Future<void> unblockUser(int userId) => caller.callServerEndpoint<void>(
        'userAuthAdmin',
        'unblockUser',
        {'userId': userId},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i5.Caller(client);
  }

  late final _i5.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i6.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    movie = EndpointMovie(this);
    media = EndpointMedia(this);
    userManager = EndpointUserManager(this);
    userAuthAdmin = EndpointUserAuthAdmin(this);
    modules = Modules(this);
  }

  late final EndpointMovie movie;

  late final EndpointMedia media;

  late final EndpointUserManager userManager;

  late final EndpointUserAuthAdmin userAuthAdmin;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'movie': movie,
        'media': media,
        'userManager': userManager,
        'userAuthAdmin': userAuthAdmin,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
