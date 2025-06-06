// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class DashboardPage extends StatefulWidget {
  final Widget child;
  const DashboardPage({super.key, required this.child});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  bool _isUserManagementExpanded = false;
  bool _isMediaExpanded = false;

  // Define navigation indices as constants for better maintainability
  static const int _dashboardIndex = 0;
  static const int _profileIndex = 1;
  static const int _usersIndex = 2;
  static const int _adminUsersIndex = 3;
  static const int _tvIndex = 4;
  static const int _movieIndex = 5;
  static const int _settingsIndex = 6;
  static const int _analyticsIndex = 7;
  static const int _supportIndex = 8;

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case _dashboardIndex:
        context.go('/dashboard');
        break;
      case _profileIndex:
        context.go('/dashboard/profile');
        break;
      case _usersIndex:
        context.go('/dashboard/users');
        break;
      case _adminUsersIndex:
        context.go('/dashboard/admin-users');
        break;
      case _tvIndex:
        context.go('/dashboard/tv-shows');
        break;
      case _movieIndex:
        context.go('/dashboard/movies');
        break;
      case _settingsIndex:
        context.go('/dashboard/settings');
        break;
      case _analyticsIndex:
        context.go('/dashboard/analytics');
        break;
      case _supportIndex:
        context.go('/dashboard/support');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Drawer
          NavigationRail(
            extended: true,
            minExtendedWidth: 200,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _handleNavigation,
            destinations: [
              const NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              NavigationRailDestination(

                icon: const Icon(Icons.people),
                selectedIcon: const Icon(Icons.people_outline) ,
                label: const Text('User'),
              ),
              NavigationRailDestination(

                icon: const Icon(Icons.people),
                selectedIcon: const Icon(Icons.people_outline) ,
                label: const Text('Admin'),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.movie),
                label: const Text('TV'),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.movie),
                label: const Text('Movie'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.analytics_outlined),
                selectedIcon: Icon(Icons.analytics),
                label: Text('Analytics'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.support_outlined),
                selectedIcon: Icon(Icons.support),
                label: Text('Support'),
              ),
            ],
          ),
          // Main Content Area
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
} 