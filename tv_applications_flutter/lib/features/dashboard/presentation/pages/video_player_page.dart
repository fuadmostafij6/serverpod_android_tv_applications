import 'package:flutter/material.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:tv_applications_client/tv_applications_client.dart';

class VideoPlayerPage extends StatefulWidget {
  final Media media;

  const VideoPlayerPage({
    super.key,
    required this.media,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  BetterPlayerController? _betterPlayerController;
  String? _errorMessage;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer();
    });
  }

  Future<void> _initializePlayer() async {
    if (!mounted) return;

    print('Initializing video player with URL: ${widget.media.url}');
    print('Cookie: ${widget.media.cookie}');
    print('User-Agent: ${widget.media.userAgent}');

    try {
      final headers = {
        "cookie": "Edge-Cache-Cookie=URLPrefix=aHR0cHM6Ly9teWJsbXByb2QtY2RuLnRvZmZlZWxpdmUuY29tLw:Expires=1748974958:KeyName=prod_live_mybl:Signature=Ew6CfabfB6eKYxi8ysB6KYDvkBv9JQ65GwZlrcDk5oEQEjcqm0NRkuTinfNFkj5e9aRHoxaHIkA9BLalf--rAQ",
        "user-agent": "Toffee (Linux;Android 14) AndroidXMedia3/1.1.1/64103898/4d2ec9b8c7534adc",
        "client-api-header": "angM1aXCHQLmmSW6cDlpXMD6tLdwnhMoUeaBBFKmd98bX6Vrae5xCMbm4gg0+u33rnxeGQDZNr2GD1tW0cWwKEpWimNlGqXVQGhpiIBz1JFxN+OxXcQqaMPrjwUhCyI5mO1DGyNv18+Z2EpmHtVnLzV9SrGsQWu4oRKjxE8QIMsRs6LrvL6hWGPlOGQke/qb5QxQZNetPzI39jHhX7Zi2XrCMIT4a+gk2Wu1c3wIybwkqknPcTp4Bj1cEF3Q+q1dV05SBhzpEDfoR2BLyQ6dV3LvmY6MNKxbUjby7hMsg35lFl2Df2mZsr7C27309w/qWi8lLXDjB7B1MozIGKn8rw3bXY5YlrPKBKztyiisAjQQi7kc5ISXyGSwRmhciwkciuitsSL0LlqHY7/Qkkh71EtaK3XEgVpLdH8zRCsTwfu1iIVPiDwTycuuBy4XWkcNnd0iLB35yftQpiL8HfpO2jQnrAwzePxszJ7mewVG+M0P/qyTBD52NkPR8uW0AZmDKp5LHTCGf7sqldDzpZvU+gsSdvtsBUcmHzjINGEoyXk=",
        "accept-encoding": "gzip",
        "origin": "https://myblmprod-cdn.toffeelive.com",
        "referer": "https://myblmprod-cdn.toffeelive.com/",
      };

      final betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.media.url,
       // headers: headers,
        liveStream: widget.media.url.contains('.m3u8'),
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: false,
          maxCacheSize: 10 * 1024 * 1024,
          maxCacheFileSize: 2 * 1024 * 1024,
        ),
      );

      final controller = BetterPlayerController(
        BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
          fit: BoxFit.contain,
          autoPlay: true,
          looping: false,
          handleLifecycle: true,
          allowedScreenSleep: false,
          errorBuilder: (context, errorMessage) {
            print('BetterPlayer error: $errorMessage');
            return _buildErrorWidget(errorMessage ?? 'Unknown error occurred');
          },
          controlsConfiguration: const BetterPlayerControlsConfiguration(
            enableSubtitles: false,
            enableAudioTracks: false,
            enablePip: false,
            enablePlayPause: true,
            enableFullscreen: true,
            enableSkips: false,
            enableOverflowMenu: false,
            enablePlaybackSpeed: false,
            loadingColor: Colors.white,
            iconsColor: Colors.white,
            liveTextColor: Colors.red,
            progressBarPlayedColor: Colors.red,
            progressBarHandleColor: Colors.red,
            progressBarBufferedColor: Colors.white,
            progressBarBackgroundColor: Colors.grey,
          ),
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      // Add event listener for errors
      controller.addEventsListener((event) {
        if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
          print('BetterPlayer exception: ${event.parameters?['exception']}');
          if (mounted) {
            setState(() {
              _errorMessage = event.parameters?['exception']?.toString() ?? 'Unknown error occurred';
            });
          }
        }
      });

      if (mounted) {
        setState(() {
          _betterPlayerController = controller;
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing video player: $e');
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            'Error: $errorMessage',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'URL: ${widget.media.url}',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          if (widget.media.cookie != null) ...[
            const SizedBox(height: 8),
            Text(
              'Cookie: ${widget.media.cookie}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
          if (widget.media.userAgent != null) ...[
            const SizedBox(height: 8),
            Text(
              'User-Agent: ${widget.media.userAgent}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _initializePlayer();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.media.title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _errorMessage != null
            ? _buildErrorWidget(_errorMessage!)
            : !_isInitialized
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      const Text(
                        'Loading video...',
                        style: TextStyle(color: Colors.white),
                      ),
                      if (widget.media.cookie != null)
                        Text(
                          'Cookie: ${widget.media.cookie}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      if (widget.media.userAgent != null)
                        Text(
                          'User-Agent: ${widget.media.userAgent}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                    ],
                  )
                : _betterPlayerController != null
                    ? BetterPlayer(controller: _betterPlayerController!)
                    : const SizedBox(),
      ),
    );
  }
} 