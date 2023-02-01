// To parse this JSON data, do
//
//     final topRatedMoviesResponse = topRatedMoviesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:movie_app/models/movie.dart';

class TopRatedMoviesResponse {
  TopRatedMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory TopRatedMoviesResponse.fromRawJson(String str) =>
      TopRatedMoviesResponse.fromJson(json.decode(str));

  factory TopRatedMoviesResponse.fromJson(Map<String, dynamic> json) =>
      TopRatedMoviesResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
