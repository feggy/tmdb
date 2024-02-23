import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/app/data/datasources/remote/repository/api_repository.dart';
import 'package:tmdb/modules/home/states/home_state.dart';

class HomeProvider extends ChangeNotifier {
  final _apiRepository = ApiRepository();

  var state = HomeState.initial();

  void init() {
    initData();
  }

  Future<void> initData() async {
    await getTrendingMovies();
  }

  Future<void> getTrendingMovies() async {
    final res = await _apiRepository.getTrendingMovies('day');

    state = state.copyWith(
      trendingMoviesOrFailureOption: optionOf(res),
      trendingMoviesIsLoading: false,
    );
    notifyListeners();
  }
}
