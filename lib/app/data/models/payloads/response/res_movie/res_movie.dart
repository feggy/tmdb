import 'package:freezed_annotation/freezed_annotation.dart';

part 'res_movie.freezed.dart';
part 'res_movie.g.dart';

@freezed
class ResMovie with _$ResMovie {
  factory ResMovie({
    bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    int? id,
    String? title,
    String? name,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_name') String? originalName,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    double? popularity,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
  }) = _ResMovie;

  factory ResMovie.fromJson(Map<String, dynamic> json) =>
      _$ResMovieFromJson(json);

  factory ResMovie.dummy() => ResMovie(
        name: 'Lorem Ipsum',
        firstAirDate: 'Lorem Ipsum',
      );
}
