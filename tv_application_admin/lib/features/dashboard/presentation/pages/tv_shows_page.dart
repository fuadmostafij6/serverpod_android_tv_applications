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
Future<List<Media>> parseM3UFromUrl(String m3uUrl, bool secured) async {
  final List<Media> mediaList = [];

  try {
    final response = await http.get(Uri.parse(m3uUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch M3U file');
    }

    final lines = LineSplitter.split(response.body).toList();

    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('#EXTINF')) {
        String infoLine = lines[i];
        String title = 'Unknown Title';
        String logoUrl = '';
        String? urlLine;
        String? userAgent;
        String? cookie;

        // Parse title
        final titleMatch = RegExp(r',(.+)$').firstMatch(infoLine);
        if (titleMatch != null) {
          title = titleMatch.group(1)?.trim() ?? 'Unknown Title';
        }

        // Parse logo
        final logoMatch = RegExp(r'tvg-logo="([^"]+)"').firstMatch(infoLine);
        if (logoMatch != null) {
          logoUrl = logoMatch.group(1) ?? '';
        }

        // Look ahead for metadata and the stream URL
        for (int j = i + 1; j < lines.length; j++) {
          final nextLine = lines[j];

          if (nextLine.startsWith('#EXTVLCOPT:http-user-agent=')) {
            userAgent = nextLine.substring(nextLine.indexOf('=') + 1).trim();
          } else if (nextLine.startsWith('#EXTHTTP:')) {
            final jsonStr = nextLine.substring('#EXTHTTP:'.length);
            try {
              final Map<String, dynamic> json = jsonDecode(jsonStr);
              cookie = json['cookie'];
            } catch (e) {
              print('Failed to parse cookie JSON: $e');
            }
          } else if (nextLine.startsWith('http')) {
            urlLine = nextLine;
            i = j; // update main index
            break;
          }
        }

        if (urlLine != null) {
          try {
            final headers = <String, String>{};

            if (userAgent != null) {
              headers['User-Agent'] = userAgent;
            }
            if (cookie != null) {
              headers['Cookie'] = cookie;
            }
            if (secured){
              mediaList.add(
                Media(
                  title: title,
                  url: urlLine,
                  channelsUrl: urlLine,
                  thumbnailUrl: logoUrl,
                  type: Type.channel,
                  userAgent: userAgent,
                  cookie: cookie,
                ),
              );
            }
            else{
              final head = await http.head(
                Uri.parse(urlLine),
                headers: headers,
              );
              print('HEAD request for $urlLine returned status: ${head.statusCode}');
              if (head.statusCode >= 200 && head.statusCode < 400) {
                mediaList.add(
                  Media(
                    title: title,
                    url: urlLine,
                    channelsUrl: urlLine,
                    thumbnailUrl: logoUrl,
                    type: Type.channel,
                    userAgent: userAgent,
                    cookie: cookie,
                  ),
                );
              }
            }


          } catch (_) {
            continue; // Skip broken URL
          }
        }
      }
      else {
        print('Skipping line: $lines');
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
      List<Media> mediaList = await parseM3UFromUrl("https://raw.githubusercontent.com/byte-capsule/Toffee-Channels-Link-Headers/refs/heads/main/toffee_OTT_Navigator.m3u", true);
     // List<Media> mediaList = await parseM3UFromUrl("https://iptv-org.github.io/iptv/categories/auto.m3u");
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
  
  Future<void> _delete() async {
    setState(() {
      _loading = true;
    });

    try {
      await client.media.deleteAllTv();
      context.read<TVShowsProvider>().loadTVShows(page: _currentPage);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading TV shows: $e')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
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
              Row(
                  children: [
                    ShadcnButton(
                      onPressed:  _delete,
                     
                      child: const Text('Delete All'),
                    ),
                    ShadcnButton(
                      onPressed: (_loading || _uploading) ? null : _startUploadFlow,
                      value: _uploading ? _uploadProgress / 100 : null,
                      isLoading: _loading || _uploading,
                      child: const Text('Bulk Actions'),
                    ),
                    const SizedBox(width: 16),
                    if (_uploading)
                      Text('Progress: $_uploadProgress%'),
                  ],
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