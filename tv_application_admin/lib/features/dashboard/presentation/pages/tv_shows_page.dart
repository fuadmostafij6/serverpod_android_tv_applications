import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_application_admin/features/dashboard/presentation/providers/tv_shows_provider.dart';
import 'package:tv_application_admin/features/dashboard/presentation/widgets/tv_show_form.dart';
import 'package:tv_application_admin/features/dashboard/presentation/widgets/tv_shows_list.dart';

class TVShowsPage extends StatefulWidget {
  const TVShowsPage({super.key});

  @override
  State<TVShowsPage> createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage> {
  @override
  void initState() {
    super.initState();
    // Load TV shows when the page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TVShowsProvider>().loadTVShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Media',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const TVShowForm(),
            const SizedBox(height: 24),
            const TVShowsList(),
          ],
        ),
      ),
    );
  }
} 