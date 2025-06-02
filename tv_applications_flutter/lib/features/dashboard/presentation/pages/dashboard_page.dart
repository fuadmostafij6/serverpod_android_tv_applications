import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tv_applications_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:tv_applications_flutter/features/dashboard/presentation/pages/tv.dart';
import 'package:tv_applications_flutter/features/dashboard/presentation/pages/widget/navigation_rail.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> bottomLabel = <String>['Info', 'Person'];
  final List<IconData> bottomIcons = <IconData>[PhosphorIconsBold.info, PhosphorIconsBold.person];

  final List<String> railLabel = <String>['TV', 'Movies', 'Series'];
  final List<IconData> railIcons = <IconData>[PhosphorIconsBold.monitor, PhosphorIconsBold.filmReel,  PhosphorIconsBold.filmReel,];

  final List<Widget> pages = [
    Tv(),
    const Center(child: Text('Movies', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Series', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 20))),
  ];
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: NavigationFlutter(
        railItemCount: railLabel.length,
        railIcons: railIcons,
        pages: pages,
        // logo: PhosphorIconsBold.githubLogo,
        profileImage: networkImage,
        navigationRailPadding: 8,
        logoSize: 15,
        navigationRailRadius: 15,
        railIconSize: 24,
        railIconsSizeHeight: 40,
        railIconsSizeWidth: 40,
        bottomIconsSize: 25,



        // bottomRailLabel: bottomLabel,
        navigationRailColor: colorScheme.onPrimary,
        railLabel: railLabel,
        railLabelActive: true,

        // bottomItemCount: bottomLabel.length,
       // bottomIcons: bottomIcons,
        activeColor: colorScheme.primary,
        inActiveColor: colorScheme.primary.withOpacity(0.2),
        onBottomIndexSelected: (int index) {},
        onNavigationRailIndexSelected: (int value) {}, logoutIcon: PhosphorIconsBold.signOut, profileClick: () {  }, logoutClick: () {  },
      ),
    );

  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 