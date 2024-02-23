import 'package:freezed_annotation/freezed_annotation.dart';

import 'created_by.dart';
import 'genre.dart';
import 'last_episode_to_air.dart';
import 'network.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'season.dart';
import 'spoken_language.dart';

part 'res_movie_details.freezed.dart';
part 'res_movie_details.g.dart';

@freezed
class ResMovieDetails with _$ResMovieDetails {
  factory ResMovieDetails({
    bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'created_by') List<CreatedBy>? createdBy,
    @JsonKey(name: 'episode_run_time') List<dynamic>? episodeRunTime,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    List<Genre>? genres,
    String? homepage,
    int? id,
    @JsonKey(name: 'in_production') bool? inProduction,
    List<String>? languages,
    @JsonKey(name: 'last_air_date') String? lastAirDate,
    @JsonKey(name: 'last_episode_to_air') LastEpisodeToAir? lastEpisodeToAir,
    String? name,
    @JsonKey(name: 'next_episode_to_air') dynamic nextEpisodeToAir,
    List<Network>? networks,
    @JsonKey(name: 'number_of_episodes') int? numberOfEpisodes,
    @JsonKey(name: 'number_of_seasons') int? numberOfSeasons,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_name') String? originalName,
    String? overview,
    double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'production_companies')
    List<ProductionCompany>? productionCompanies,
    @JsonKey(name: 'production_countries')
    List<ProductionCountry>? productionCountries,
    List<Season>? seasons,
    @JsonKey(name: 'spoken_languages') List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? type,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
  }) = _ResMovieDetails;

  factory ResMovieDetails.fromJson(Map<String, dynamic> json) =>
      _$ResMovieDetailsFromJson(json);
}
