import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_application_admin/features/auth/presentation/providers/auth_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

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
  static const int _userManagementIndex = 2;
  static const int _usersIndex = 3;
  static const int _adminUsersIndex = 4;
  static const int _mediaIndex = 5;
  static const int _tvIndex = 6;
  static const int _movieIndex = 7;
  static const int _settingsIndex = 8;
  static const int _analyticsIndex = 9;
  static const int _supportIndex = 10;

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 240,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'TV Application Admin',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _buildNavItem(
                        icon: Icons.dashboard_outlined,
                        selectedIcon: Icons.dashboard,
                        label: 'Dashboard',
                        index: _dashboardIndex,
                        onTap: () => _handleNavigation(_dashboardIndex),
                      ),
                      _buildNavItem(
                        icon: Icons.person_outline,
                        selectedIcon: Icons.person,
                        label: 'Profile',
                        index: _profileIndex,
                        onTap: () => _handleNavigation(_profileIndex),
                      ),
                      _buildExpandableNavItem(
                        icon: Icons.people_outline,
                        selectedIcon: Icons.people,
                        label: 'User Management',
                        index: _userManagementIndex,
                        isExpanded: _isUserManagementExpanded,
                        onExpandedChanged: (expanded) {
                          setState(() {
                            _isUserManagementExpanded = expanded;
                          });
                        },
                        children: [
                          _buildSubNavItem(
                            label: 'Users',
                            index: _usersIndex,
                            onTap: () => _handleNavigation(_usersIndex),
                          ),
                          _buildSubNavItem(
                            label: 'Admin Users',
                            index: _adminUsersIndex,
                            onTap: () => _handleNavigation(_adminUsersIndex),
                          ),
                        ],
                      ),
                      _buildExpandableNavItem(
                        icon: Icons.movie_outlined,
                        selectedIcon: Icons.movie,
                        label: 'Media',
                        index: _mediaIndex,
                        isExpanded: _isMediaExpanded,
                        onExpandedChanged: (expanded) {
                          setState(() {
                            _isMediaExpanded = expanded;
                          });
                        },
                        children: [
                          _buildSubNavItem(
                            label: 'TV Shows',
                            index: _tvIndex,
                            onTap: () => _handleNavigation(_tvIndex),
                          ),
                          _buildSubNavItem(
                            label: 'Movies',
                            index: _movieIndex,
                            onTap: () => _handleNavigation(_movieIndex),
                          ),
                        ],
                      ),
                      _buildNavItem(
                        icon: Icons.settings_outlined,
                        selectedIcon: Icons.settings,
                        label: 'Settings',
                        index: _settingsIndex,
                        onTap: () => _handleNavigation(_settingsIndex),
                      ),
                      _buildNavItem(
                        icon: Icons.analytics_outlined,
                        selectedIcon: Icons.analytics,
                        label: 'Analytics',
                        index: _analyticsIndex,
                        onTap: () => _handleNavigation(_analyticsIndex),
                      ),
                      _buildNavItem(
                        icon: Icons.support_agent_outlined,
                        selectedIcon: Icons.support_agent,
                        label: 'Support',
                        index: _supportIndex,
                        onTap: () => _handleNavigation(_supportIndex),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildNavItem(
                    icon: Icons.logout,
                    selectedIcon: Icons.logout,
                    label: 'Logout',
                    onTap: () async {
                      await context.read<AuthProvider>().logout();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getPageTitle(),
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GoRouter.of(context).routerDelegate.currentConfiguration.uri.path == '/dashboard'
                      ? _buildPageContent()
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    int? index,
    VoidCallback? onTap,
  }) {
    final isSelected = index != null && _selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(
        isSelected ? selectedIcon : icon,
        color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: colorScheme.primaryContainer.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildExpandableNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
    required List<Widget> children,
    required bool isExpanded,
    required ValueChanged<bool> onExpandedChanged,
  }) {
    final isSelected = _selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(
            isSelected ? selectedIcon : icon,
            color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
          title: Text(
            label,
            style: TextStyle(
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: colorScheme.onSurfaceVariant,
          ),
          onTap: () {
            onExpandedChanged(!isExpanded);
            if (!isExpanded) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          selected: isSelected,
          selectedTileColor: colorScheme.primaryContainer.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 4),
          ...children,
        ],
      ],
    );
  }

  Widget _buildSubNavItem({
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        selected: isSelected,
        selectedTileColor: colorScheme.primaryContainer.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  String _getPageTitle() {
    switch (_selectedIndex) {
      case _dashboardIndex:
        return 'Dashboard';
      case _profileIndex:
        return 'Profile';
      case _userManagementIndex:
        return 'User Management';
      case _usersIndex:
        return 'Users';
      case _adminUsersIndex:
        return 'Admin Users';
      case _mediaIndex:
        return 'Media Management';
      case _tvIndex:
        return 'TV Shows';
      case _movieIndex:
        return 'Movies';
      case _settingsIndex:
        return 'Settings';
      case _analyticsIndex:
        return 'Analytics';
      case _supportIndex:
        return 'Support';
      default:
        return 'Dashboard';
    }
  }

  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case _dashboardIndex:
        return const Center(child: Text('Dashboard Content'));
      case _profileIndex:
        return const Center(child: Text('Profile Content'));
      case _userManagementIndex:
        return const Center(child: Text('User Management Content'));
      case _usersIndex:
        return const Center(child: Text('Users Content'));
      case _adminUsersIndex:
        return const Center(child: Text('Admin Users Content'));
      case _mediaIndex:
        return const Center(child: Text('Media Management Content'));
      case _tvIndex:
        return const Center(child: Text('TV Shows Content'));
      case _movieIndex:
        return const Center(child: Text('Movies Content'));
      case _settingsIndex:
        return const Center(child: Text('Settings Content'));
      case _analyticsIndex:
        return const Center(child: Text('Analytics Content'));
      case _supportIndex:
        return const Center(child: Text('Support Content'));
      default:
        return const Center(child: Text('Dashboard Content'));
    }
  }
} 