import 'package:serverpod/serverpod.dart';
import 'package:tv_applications_server/src/web/routes/root.dart';
import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;


void run(List<String> args) async {

  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  pod.webServer.addRoute(RouteStaticDirectory(serverDirectory: 'static', basePath: '/'), '/*',);

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      session.log(
        validationCode,
        level: LogLevel.info,
      );
      print(validationCode);
      return true;
    },

    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      session.log(
        validationCode,
        level: LogLevel.info,
      );
      print(validationCode);
      return true;
    },
  ));

  // Start the server.
  await pod.start();



}
