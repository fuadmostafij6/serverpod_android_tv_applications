import 'package:flutter/material.dart';
import 'package:tv_application_admin/main.dart';
import 'package:tv_applications_client/tv_applications_client.dart';

class TVShowsProvider extends ChangeNotifier {
  List<Media> _tvShows = [];
  bool _isLoading = false;
  String? _error;

  List<Media> get tvShows => _tvShows;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTVShows() async {
    _setLoading(true);
    try {
      _tvShows = await client.media.getAllTv();
      _error = null;
    } catch (e) {
      _error = 'Error loading TV shows: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addTVShow({
    required String title,
    required String url,
    required Type type,
    required String thumbnailUrl,
    String? channelsUrl,
    List<Movie>? shows,
  }) async {
    _setLoading(true);
    try {
      final newTVShow = Media(
        title: title,
        url: url,
        type: type,
        thumbnailUrl: thumbnailUrl,
        channelsUrl: channelsUrl,
        shows: shows,
      );

     await client.media.createTv(newTVShow);
      _tvShows.add(newTVShow);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = 'Error adding TV show: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateTVShow(Media tvShow) async {
    _setLoading(true);
    try {
      await client.media.updateTv(tvShow);
      final index = _tvShows.indexWhere((t) => t.id == tvShow.id);
      if (index != -1) {
        _tvShows[index] = tvShow;
        _error = null;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error updating TV show: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateMovieInShow(int tvShowId, Movie movie) async {
    _setLoading(true);
    try {
      final index = _tvShows.indexWhere((t) => t.id == tvShowId);
      if (index != -1) {
        final tvShow = _tvShows[index];
        if (tvShow.type == Type.shows && tvShow.shows != null) {
          final updatedShows = tvShow.shows!.map((m) {
            if (m.id == movie.id) {
              return movie;
            }
            return m;
          }).toList();
          final updatedTVShow = tvShow.copyWith(shows: updatedShows);
          await updateTVShow(updatedTVShow);
        }
      }
    } catch (e) {
      _error = 'Error updating movie in show: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteTVShow(int id) async {
    _setLoading(true);
    try {
      // TODO: Implement deleting TV show from the server
      _tvShows.removeWhere((t) => t.id == id);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = 'Error deleting TV show: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addMovieToShow(int tvShowId, Movie movie) async {
    _setLoading(true);
    try {
      final index = _tvShows.indexWhere((t) => t.id == tvShowId);
      if (index != -1) {
        final tvShow = _tvShows[index];
        if (tvShow.type == Type.shows) {
          final updatedShows = [...?tvShow.shows, movie];
          final updatedTVShow = tvShow.copyWith(shows: updatedShows);
          _tvShows[index] = updatedTVShow;
          _error = null;
          notifyListeners();
        }
      }
    } catch (e) {
      _error = 'Error adding movie to show: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removeMovieFromShow(int tvShowId, int movieId) async {
    _setLoading(true);
    try {
      final index = _tvShows.indexWhere((t) => t.id == tvShowId);
      if (index != -1) {
        final tvShow = _tvShows[index];
        if (tvShow.type == Type.shows && tvShow.shows != null) {
          final updatedShows = tvShow.shows!
              .where((movie) => movie.id != movieId)
              .toList();
          final updatedTVShow = tvShow.copyWith(shows: updatedShows);
          _tvShows[index] = updatedTVShow;
          _error = null;
          notifyListeners();
        }
      }
    } catch (e) {
      _error = 'Error removing movie from show: $e';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 