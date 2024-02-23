import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb/app/data/models/entities/failure.dart';
import 'package:tmdb/app/data/models/payloads/response/res_cast/res_cast.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie/res_movie.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie_details/res_movie_details.dart';

part 'movie_details_state.freezed.dart';

@freezed
class MovieDetailsState with _$MovieDetailsState {
  const factory MovieDetailsState({
    required ResMovie movie,
    required Option<Either<Failure, ResMovieDetails>>
        movieDetailsOrFailureOption,
    required Option<Either<Failure, ResCast>> castOrFailureOption,
    required bool isLoading,
  }) = _MovieDetailsState;

  factory MovieDetailsState.initial() => MovieDetailsState(
        movie: ResMovie(),
        movieDetailsOrFailureOption: none(),
        castOrFailureOption: none(),
        isLoading: true,
      );
}
