// To parse this JSON data, do
//
//     final upcomingResponse = upcomingResponseFromJson(jsonString);

import 'dart:convert';

import 'movie.dart';

class UpcomingMoviesResponse {
  UpcomingMoviesResponse({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates? dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory UpcomingMoviesResponse.fromRawJson(String str) =>
      UpcomingMoviesResponse.fromJson(json.decode(str));

  factory UpcomingMoviesResponse.fromJson(Map<String, dynamic> json) =>
      UpcomingMoviesResponse(
        dates: json['dates'] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
