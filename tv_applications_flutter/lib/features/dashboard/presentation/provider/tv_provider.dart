


import 'package:flutter/material.dart';
import 'package:tv_applications_client/tv_applications_client.dart';
import 'package:tv_applications_flutter/main.dart';

class TvProvider extends ChangeNotifier {

  List<Media> _tvShows = [];
  bool _isLoading = false;
  String? _error;

  List<Media> get tvShows => _tvShows;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTVShows({int tvPerPage = 10, required int page}) async {
    _setLoading(true);
    // print('Loading TV shows for page $page with $tvPerPage items per page');
    try {

      final newTvShows = await client.media.getAllTv(page: page, tvPerPage: tvPerPage);
      _tvShows.addAll(newTvShows);


      _error = null;
      notifyListeners();
    } catch (e) {
      _error = 'Error loading TV shows: $e';
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