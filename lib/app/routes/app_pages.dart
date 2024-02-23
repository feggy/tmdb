import 'package:tmdb/app/routes/app_routes.dart';
import 'package:tmdb/modules/home/pages/home_page.dart';
import 'package:tmdb/modules/movie_details/pages/movie_details_page.dart';

final routes = {
  Routes.init: (context) => const HomePage(),
  Routes.movieDetails: (context) => const MovieDetailsPage(),
};
