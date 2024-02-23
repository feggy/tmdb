import 'package:dartz/dartz.dart';
import 'package:tmdb/app/core/modules/dio_module.dart';
import 'package:tmdb/app/core/utils/extensions.dart';
import 'package:tmdb/app/data/models/entities/failure.dart';
import 'package:tmdb/app/data/models/payloads/response/base_pagination.dart';
import 'package:tmdb/app/data/models/payloads/response/res_cast/res_cast.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie/res_movie.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie_details/res_movie_details.dart';

class ApiRepository {
  final _service = DioModule().apiService;

  Future<Either<Failure, BasePagination<List<ResMovie>>>> getTrendingMovies(
          String time) =>
      safeRemoteCall(remoteCall: () => _service.getTrendingMovies(time));

  Future<Either<Failure, ResMovieDetails>> getTvDetails(int seriesId) =>
      safeRemoteCall(remoteCall: () => _service.getTvDetails(seriesId));

  Future<Either<Failure, ResCast>> getCast(int seriesId) =>
      safeRemoteCall(remoteCall: () => _service.getCast(seriesId));
}
