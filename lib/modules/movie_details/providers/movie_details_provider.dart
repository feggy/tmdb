import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/app/data/datasources/remote/repository/api_repository.dart';
import 'package:tmdb/app/data/models/entities/failure.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie/res_movie.dart';
import 'package:tmdb/modules/movie_details/states/movie_details_state.dart';

class MovieDetailsProvider extends ChangeNotifier {
  MovieDetailsProvider(this.context);

  BuildContext context;

  final _apiRepository = ApiRepository();
  var state = MovieDetailsState.initial();

  void init() {
    initArgs();
    initData();
  }

  void initArgs() {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is ResMovie) {
      state = state.copyWith(movie: args);
      notifyListeners();
    }
  }

  Future<void> initData() async {
    await getMovieDetails();
    await getCast();
  }

  Future<void> getMovieDetails() async {
    if (state.movie.mediaType != 'tv') {
      state = state.copyWith(
        movieDetailsOrFailureOption: optionOf(
            left(Failure(message: 'For now, only TV shows are supported.'))),
        isLoading: false,
      );
      notifyListeners();

      return;
    }

    if (state.movie.id != null) {
      final res = await _apiRepository.getTvDetails(state.movie.id!);
      state = state.copyWith(
        movieDetailsOrFailureOption: optionOf(res),
        isLoading: false,
      );
      notifyListeners();
    }
  }

  Future<void> getCast() async {
    if (state.movie.id != null) {
      final res = await _apiRepository.getCast(state.movie.id!);
      state = state.copyWith(
        castOrFailureOption: optionOf(res),
        isLoading: false,
      );
      notifyListeners();
    }
  }
}
