/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/movie_endpoint.dart' as _i2;
import '../endpoints/tv_endpoint.dart' as _i3;
import '../endpoints/user_auth.dart' as _i4;
import '../endpoints/user_auth_admin.dart' as _i5;
import 'package:tv_applications_server/src/generated/movie.dart' as _i6;
import 'package:tv_applications_server/src/generated/media.dart' as _i7;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i8;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'movie': _i2.MovieEndpoint()
        ..initialize(
          server,
          'movie',
          null,
        ),
      'media': _i3.MediaEndpoint()
        ..initialize(
          server,
          'media',
          null,
        ),
      'userManager': _i4.UserManager()
        ..initialize(
          server,
          'userManager',
          null,
        ),
      'userAuthAdmin': _i5.UserAuthAdmin()
        ..initialize(
          server,
          'userAuthAdmin',
          null,
        ),
    };
    connectors['movie'] = _i1.EndpointConnector(
      name: 'movie',
      endpoint: endpoints['movie']!,
      methodConnectors: {
        'createMovie': _i1.MethodConnector(
          name: 'createMovie',
          params: {
            'movie': _i1.ParameterDescription(
              name: 'movie',
              type: _i1.getType<_i6.Movie>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['movie'] as _i2.MovieEndpoint).createMovie(
            session,
            params['movie'],
          ),
        ),
        'deleteMovie': _i1.MethodConnector(
          name: 'deleteMovie',
          params: {
            'movie': _i1.ParameterDescription(
              name: 'movie',
              type: _i1.getType<_i6.Movie>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['movie'] as _i2.MovieEndpoint).deleteMovie(
            session,
            params['movie'],
          ),
        ),
        'updateMovie': _i1.MethodConnector(
          name: 'updateMovie',
          params: {
            'movie': _i1.ParameterDescription(
              name: 'movie',
              type: _i1.getType<_i6.Movie>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['movie'] as _i2.MovieEndpoint).updateMovie(
            session,
            params['movie'],
          ),
        ),
        'getAllMovie': _i1.MethodConnector(
          name: 'getAllMovie',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['movie'] as _i2.MovieEndpoint).getAllMovie(session),
        ),
      },
    );
    connectors['media'] = _i1.EndpointConnector(
      name: 'media',
      endpoint: endpoints['media']!,
      methodConnectors: {
        'createTv': _i1.MethodConnector(
          name: 'createTv',
          params: {
            'tv': _i1.ParameterDescription(
              name: 'tv',
              type: _i1.getType<_i7.Media>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['media'] as _i3.MediaEndpoint).createTv(
            session,
            params['tv'],
          ),
        ),
        'deleteTv': _i1.MethodConnector(
          name: 'deleteTv',
          params: {
            'tv': _i1.ParameterDescription(
              name: 'tv',
              type: _i1.getType<_i7.Media>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['media'] as _i3.MediaEndpoint).deleteTv(
            session,
            params['tv'],
          ),
        ),
        'updateTv': _i1.MethodConnector(
          name: 'updateTv',
          params: {
            'tv': _i1.ParameterDescription(
              name: 'tv',
              type: _i1.getType<_i7.Media>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['media'] as _i3.MediaEndpoint).updateTv(
            session,
            params['tv'],
          ),
        ),
        'getAllTv': _i1.MethodConnector(
          name: 'getAllTv',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['media'] as _i3.MediaEndpoint).getAllTv(session),
        ),
      },
    );
    connectors['userManager'] = _i1.EndpointConnector(
      name: 'userManager',
      endpoint: endpoints['userManager']!,
      methodConnectors: {
        'isSignIn': _i1.MethodConnector(
          name: 'isSignIn',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userManager'] as _i4.UserManager).isSignIn(session),
        ),
        'getUserInfo': _i1.MethodConnector(
          name: 'getUserInfo',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userManager'] as _i4.UserManager).getUserInfo(
            session,
            params['email'],
          ),
        ),
        'updateScopeWithAdmin': _i1.MethodConnector(
          name: 'updateScopeWithAdmin',
          params: {
            'targetUserId': _i1.ParameterDescription(
              name: 'targetUserId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userManager'] as _i4.UserManager)
                  .updateScopeWithAdmin(
            session,
            params['targetUserId'],
          ),
        ),
      },
    );
    connectors['userAuthAdmin'] = _i1.EndpointConnector(
      name: 'userAuthAdmin',
      endpoint: endpoints['userAuthAdmin']!,
      methodConnectors: {
        'listUsers': _i1.MethodConnector(
          name: 'listUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userAuthAdmin'] as _i5.UserAuthAdmin)
                  .listUsers(session),
        ),
        'getUserById': _i1.MethodConnector(
          name: 'getUserById',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userAuthAdmin'] as _i5.UserAuthAdmin).getUserById(
            session,
            params['userId'],
          ),
        ),
        'blockUser': _i1.MethodConnector(
          name: 'blockUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userAuthAdmin'] as _i5.UserAuthAdmin).blockUser(
            session,
            params['userId'],
          ),
        ),
        'unblockUser': _i1.MethodConnector(
          name: 'unblockUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userAuthAdmin'] as _i5.UserAuthAdmin).unblockUser(
            session,
            params['userId'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i8.Endpoints()..initializeEndpoints(server);
  }
}
