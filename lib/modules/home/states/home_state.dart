import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb/app/data/models/entities/failure.dart';
import 'package:tmdb/app/data/models/payloads/response/base_pagination.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie/res_movie.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required Option<Either<Failure, BasePagination<List<ResMovie>>>>
        trendingMoviesOrFailureOption,
    required bool trendingMoviesIsLoading,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        trendingMoviesOrFailureOption: none(),
        trendingMoviesIsLoading: true,
      );
}
