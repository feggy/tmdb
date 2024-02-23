import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb/app/data/models/payloads/response/base_pagination.dart';
import 'package:tmdb/app/data/models/payloads/response/res_cast/res_cast.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie/res_movie.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie_details/res_movie_details.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/trending/all/{time}')
  Future<BasePagination<List<ResMovie>>> getTrendingMovies(
      @Path('time') String time);

  @GET('/tv/{seriesId}')
  Future<ResMovieDetails> getTvDetails(@Path('seriesId') int seriesId);

  @GET('/tv/{seriesId}/credits')
  Future<ResCast> getCast(@Path('seriesId') int seriesId);
}
