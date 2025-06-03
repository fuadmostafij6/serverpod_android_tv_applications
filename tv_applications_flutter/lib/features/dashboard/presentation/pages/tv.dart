import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_applications_client/tv_applications_client.dart';
import '../provider/tv_provider.dart';
import 'video_player_page.dart';

class Tv extends StatefulWidget {
  const Tv({super.key});

  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  static const int _tvPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvProvider>().loadTVShows(page: _currentPage, tvPerPage: _tvPerPage);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (!context.read<TvProvider>().isLoading) {
      _currentPage++;
      context.read<TvProvider>().loadTVShows(page: _currentPage, tvPerPage: _tvPerPage);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvProvider>(
        builder: (context, tvProvider, child) {
          if (tvProvider.error != null) {
            return Center(
              child: Text(
                tvProvider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (tvProvider.tvShows.isEmpty && tvProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: tvProvider.tvShows.length + (tvProvider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == tvProvider.tvShows.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final tvShow = tvProvider.tvShows[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerPage(media: tvShow),
                    ),
                  );
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            return Image.network(
                              tvShow.thumbnailUrl,
                              headers: {
                                // 'Access-Control-Allow-Origin': '*',
                                if (tvShow.cookie != null) 'Cookie': tvShow.cookie!,
                                if (tvShow.userAgent != null) 'User-Agent': tvShow.userAgent!,
                              },
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return const Center(
                                  child: Icon(Icons.error_outline),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tvShow.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (tvShow.cookie != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cookie: ${tvShow.cookie}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (tvShow.userAgent != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'User-Agent: ${tvShow.userAgent}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
