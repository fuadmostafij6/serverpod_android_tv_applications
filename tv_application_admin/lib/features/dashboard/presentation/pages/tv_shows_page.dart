import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:tv_application_admin/core/ui/components/button.dart' show ShadcnButton;
import 'package:tv_application_admin/features/dashboard/presentation/providers/tv_shows_provider.dart';
import 'package:tv_application_admin/features/dashboard/presentation/widgets/tv_show_form.dart';
import 'package:tv_application_admin/features/dashboard/presentation/widgets/tv_shows_list.dart';
import 'package:tv_application_admin/main.dart';
import 'package:tv_applications_client/tv_applications_client.dart';

import 'package:http/http.dart' as http;
Future<List<Media>> parseM3UFromUrl(String m3uUrl) async {
  final List<Media> mediaList = [];

  try {
    final response = await http.get(Uri.parse(m3uUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch M3U file');
    }

    final lines = LineSplitter.split(response.body).toList();
    print(lines.length);

    for (int i = 0; i < lines.length - 1; i++) {
      if (lines[i].startsWith('#EXTINF')) {
        final infoLine = lines[i];
        final urlLine = lines[i + 1];

        // Ensure it's a URL
        if (!urlLine.startsWith('http')) continue;

        // Extract title
        final titleMatch = RegExp(r',(.+)$').firstMatch(infoLine);
        final title = titleMatch?.group(1)?.trim() ?? 'Unknown Title';

        // Extract thumbnail URL
        final logoMatch = RegExp(r'tvg-logo="([^"]+)"').firstMatch(infoLine);
        final logoUrl = logoMatch?.group(1) ?? '';

        // Optional: Check if URL is working
        try {
          final head = await http.head(Uri.parse(urlLine));
          if (head.statusCode >= 200 && head.statusCode < 400) {
            mediaList.add(
              Media(
                title: title,
                url: urlLine,
                channelsUrl: urlLine,
                thumbnailUrl: logoUrl, type: Type.channel,
              ),
            );
          }
          print("success: $i");
        } catch (_) {
          print("error: $i");
          continue; // Skip bad links
        }
      }
    }
  } catch (e) {
    print('Error parsing M3U: $e');
  }

  return mediaList;
}
class TVShowsPage extends StatefulWidget {
  const TVShowsPage({super.key});

  @override
  State<TVShowsPage> createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage> {
  int _uploadProgress = 0;
  bool _loading = false;
  bool _uploading = false;
  int _currentPage = 1;
  Future<void> _startUploadFlow() async {
    setState(() {
      _loading = true;
      _uploadProgress = 0;
    });

    try {
      // STEP 1: Parse M3U file from URL
      List<Media> mediaList = await parseM3UFromUrl("https://iptv-org.github.io/iptv/categories/sports.m3u");
      print("Parsed ${mediaList.length} media items from M3U file.");

      setState(() {
        _loading = false;
        _uploading = true;
      });

      // STEP 2: Upload in chunks with progress
      const chunkSize = 10;
      final total = mediaList.length;

      for (int i = 0; i < total; i += chunkSize) {
        final chunk = mediaList.sublist(
          i,
          (i + chunkSize > total) ? total : i + chunkSize,
        );

        try {
          await client.media.insertMediaList(chunk);
        } catch (e) {
          debugPrint('Upload error for chunk: $e');
        }

        final percent = (((i + chunk.length) / total) * 100).round();
        setState(() {
          _uploadProgress = percent;
        });
      }

      setState(() {
        _uploading = false;
      });
      context.read<TVShowsProvider>().loadTVShows(page:1 );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload complete!')),
      );
    } catch (e) {
      setState(() {
        _loading = false;
        _uploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Load TV shows when the page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TVShowsProvider>().loadTVShows(page: _currentPage);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Media',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ShadcnButton(
                  onPressed: (_loading || _uploading) ? null : _startUploadFlow,
                    value: _uploading ? _uploadProgress / 100 : null,
                  isLoading: _loading || _uploading,
                  child: const Text('Bulk Actions'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const TVShowForm(),
            const SizedBox(height: 24),
            const TVShowsList(),
            NumberPaginator(
              numberPages: 10,

              onPageChange: (int index) {
                setState(() {
                  _currentPage = index + 1;
                });
                context.read<TVShowsProvider>().loadTVShows(page: _currentPage);
              },
            )
          ],
        ),
      ),
    );
  }
} 