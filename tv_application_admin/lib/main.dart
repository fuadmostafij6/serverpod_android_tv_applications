import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:tv_applications_client/tv_applications_client.dart';
import 'package:tv_application_admin/features/auth/presentation/pages/login_page.dart';
import 'package:tv_application_admin/features/auth/presentation/pages/email_verification_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/profile_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/users_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/admin_users_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/tv_shows_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/movies_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/settings_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/analytics_page.dart';
import 'package:tv_application_admin/features/dashboard/presentation/pages/support_page.dart';
import 'package:tv_application_admin/features/auth/presentation/providers/auth_provider.dart';
import 'package:tv_application_admin/features/splash/presentation/pages/splash_page.dart';



late Client client;
late SessionManager sessionManager;

Future<void> initializeServerpodClient() async {
  // The android emulator does not have access to the localhost of the machine.
  // const ipAddress = '10.0.2.2'; // Android emulator ip for the host

  // On a real device replace the ipAddress with the IP address of your computer.
  const ipAddress = 'localhost';

  // Sets up a singleton client object that can be used to talk to the server from
  // anywhere in our app. The client is generated from your server code.
  // The client is set up to connect to a Serverpod running on a local server on
  // the default port. You will need to modify this to connect to staging or
  // production servers.
  client = Client(
    'http://$ipAddress:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // The session manager keeps track of the signed-in state of the user. You
  // can query it to see if the user is currently signed in and get information
  // about the user.

  sessionManager = SessionManager(
    caller: client.modules.auth, // 👈 This is crucial
  );
  await sessionManager.initialize();
  // await sessionManager.initialize();
}

Future<void> main() async {
  await initializeServerpodClient();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    // GoRoute(
    //   path: '/register',
    //   builder: (context, state) => const RegisterPage(),
    // ),
    GoRoute(
      path: '/verify-email',
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return EmailVerificationPage(email: email);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => const DashboardPage(),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const Center(child: Text('Dashboard Content')),
        ),
        GoRoute(
          path: '/dashboard/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/dashboard/users',
          builder: (context, state) => const UsersPage(),
        ),
        GoRoute(
          path: '/dashboard/admin-users',
          builder: (context, state) => const AdminUsersPage(),
        ),
        GoRoute(
          path: '/dashboard/tv-shows',
          builder: (context, state) => const TVShowsPage(),
        ),
        GoRoute(
          path: '/dashboard/movies',
          builder: (context, state) => const MoviesPage(),
        ),
        GoRoute(
          path: '/dashboard/settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/dashboard/analytics',
          builder: (context, state) => const AnalyticsPage(),
        ),
        GoRoute(
          path: '/dashboard/support',
          builder: (context, state) => const SupportPage(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TV Applications',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}


