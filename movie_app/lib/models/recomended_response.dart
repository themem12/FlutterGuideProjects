// To parse this JSON data, do
//
//     final recomendedResponse = recomendedResponseFromJson(jsonString);

import 'dart:convert';

import 'package:movie_app/models/movie.dart';

class RecomendedResponse {
  RecomendedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory RecomendedResponse.fromRawJson(String str) =>
      RecomendedResponse.fromJson(json.decode(str));

  factory RecomendedResponse.fromJson(Map<String, dynamic> json) =>
      RecomendedResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
