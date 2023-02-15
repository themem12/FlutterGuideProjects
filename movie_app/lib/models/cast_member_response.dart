// To parse this JSON data, do
//
//     final castMemberResponse = castMemberResponseFromJson(jsonString);

import 'dart:convert';

class CastMemberResponse {
  CastMemberResponse({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    this.deathday,
    required this.gender,
    this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  bool adult;
  List<String> alsoKnownAs;
  String biography;
  DateTime? birthday;
  String? deathday;
  int gender;
  dynamic homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  factory CastMemberResponse.fromRawJson(String str) =>
      CastMemberResponse.fromJson(json.decode(str));

  factory CastMemberResponse.fromJson(Map<String, dynamic> json) =>
      CastMemberResponse(
        adult: json["adult"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"],
        birthday: json["birthday"] != null ? DateTime.parse(json["birthday"]) : null,
        deathday: json["deathday"],
        gender: json["gender"],
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"] ?? '',
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"] ?? '',
      );

  String getBirthDate() {
    if(birthday == null ) return '';
    final dateString = '$birthday';
    final dateSplitted = dateString.split(' ');

    return dateSplitted[0];
  }

  String getDeathDate() {
    final dateString = '$deathday';
    final dateSplitted = dateString.split(' ');

    return dateSplitted[0];
  }
}
