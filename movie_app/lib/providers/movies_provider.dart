import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/debouncer.dart';
import 'package:movie_app/models/cast_member_response.dart';
import 'package:movie_app/models/credits_response.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/now_playing_response.dart';
import 'package:movie_app/models/popular_response.dart';
import 'package:movie_app/models/recomended_response.dart';
import 'package:movie_app/models/search_movies_response.dart';
import 'package:movie_app/models/top_rated_movies_response.dart';
import 'package:movie_app/models/upcoming_movies_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseURL = 'api.themoviedb.org';
  final String _apiKey = 'b530344e6b35b9e51dd69f6609edec84';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> recomendedMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  int _topRatedPage = 0;
  int _upcomingPage = 0;
  int _recomendedPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionsStramController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionsStream =>
      _suggestionsStramController.stream;

  MoviesProvider() {
    getOnNowPlayingMovies();
    getPopularMovies();
    getTopRatedMovies();
    getUpcomingMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(
      _baseURL,
      endpoint,
      {'api_key': _apiKey, 'language': _language, 'page': '$page'},
    );

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    return response.body;
  }

  getOnNowPlayingMovies() async {
    // Await the http get response, then decode the json-formatted response.
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage += 1;
    // Await the http get response, then decode the json-formatted response.
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromRawJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }

  getTopRatedMovies() async {
    _topRatedPage += 1;
    // Await the http get response, then decode the json-formatted response.
    final jsonData = await _getJsonData('3/movie/top_rated', _topRatedPage);
    final topRatedResponse = TopRatedMoviesResponse.fromRawJson(jsonData);

    topRatedMovies = [...topRatedMovies, ...topRatedResponse.results];

    notifyListeners();
  }

  getUpcomingMovies() async {
    _upcomingPage += 1;
    // Await the http get response, then decode the json-formatted response.
    final jsonData = await _getJsonData('3/movie/upcoming', _upcomingPage);
    final upcomingResponse = UpcomingMoviesResponse.fromRawJson(jsonData);

    upcomingMovies = [...upcomingMovies, ...upcomingResponse.results];

    notifyListeners();
  }

  Future<CastMemberResponse> getCastMemberInfo(int castId) async {
    final url = Uri.https(
      _baseURL,
      '3/person/$castId',
      {'api_key': _apiKey, 'language': _language},
    );

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    final jsonData = response.body;
    final castMemberResponse = CastMemberResponse.fromRawJson(jsonData);

    return castMemberResponse;
  }

  Future<List<Movie>> getRecomendedMovies(int movieId) async {
    _recomendedPage += 1;
    // Await the http get response, then decode the json-formatted response.
    final jsonData =
        await _getJsonData('3/movie/$movieId/similar', _recomendedPage);
    final recomendedResponse = RecomendedResponse.fromRawJson(jsonData);

    recomendedMovies = [...recomendedMovies, ...recomendedResponse.results];

    return recomendedMovies;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast[movieId] != null) {
      return moviesCast[movieId]!;
    }

    final jsonData = await _getJsonData('3/movie/$movieId/credits');

    final creditsResponse = CreditsResponse.fromRawJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(
      _baseURL,
      '3/search/movie',
      {'api_key': _apiKey, 'language': _language, 'query': query},
    );

    final response = await http.get(url);
    final SearchMoviesResponse searchMoviesResponse =
        SearchMoviesResponse.fromRawJson(response.body);

    return searchMoviesResponse.results;
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);
      _suggestionsStramController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
