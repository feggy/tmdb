import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie/res_movie.dart';
import 'package:tmdb/app/routes/app_routes.dart';
import 'package:tmdb/modules/home/providers/home_provider.dart';
import 'package:tmdb/shared/themes/colors.dart';
import 'package:tmdb/shared/themes/texts.dart';
import 'package:tmdb/shared/values/constants.dart';
import 'package:tmdb/shared/widgets/image_network_custom_widget.dart';
import 'package:tmdb/shared/widgets/text_custom_widget.dart';
import 'package:tmdb/shared/widgets/text_field_custom_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
      builder: (context, child) => const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<HomeProvider>().init());
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: const ImageNetworkCustomWidget(
              imageUrl:
                  'https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg',
              svgColorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          actions: [
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 15),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return ListView(
              children: [
                _headerWidget(),
                _trendingMoviesWidget(value),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _trendingMoviesWidget(HomeProvider value) {
    return value.state.trendingMoviesOrFailureOption.fold(
      () => _movieRowsWidget(
        title: 'Trending',
        isLoading: value.state.trendingMoviesIsLoading,
        items: [],
      ),
      (either) => either.fold(
        (l) => const SizedBox(),
        (r) => _movieRowsWidget(
          title: 'Trending',
          isLoading: value.state.trendingMoviesIsLoading,
          items: r.results ?? [],
        ),
      ),
    );
  }

  Widget _movieRowsWidget({
    required String title,
    required bool isLoading,
    required List<ResMovie> items,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustomWidget(
              text: title,
              style: rowsTitleStyle,
              margin: const EdgeInsets.only(left: 24),
            ),
            SizedBox(
              width: double.infinity,
              height: 350,
              child: MasonryGridView.count(
                shrinkWrap: true,
                crossAxisCount: 1,
                itemBuilder: (context, index) {
                  final e = isLoading ? ResMovie.dummy() : items[index];

                  return _movieItemWidget(data: e);
                },
                scrollDirection: Axis.horizontal,
                itemCount: isLoading ? 3 : items.length,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _movieItemWidget({required ResMovie data}) {
    return GestureDetector(
      onTap: () {
        if (data.id == null) return;

        Navigator.pushNamed(
          context,
          Routes.movieDetails,
          arguments: data,
        );
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageNetworkCustomWidget(
              height: 225,
              imageUrl: '$imageBaseUrl${data.posterPath}',
              borderRadius: BorderRadius.circular(10),
            ),
            TextCustomWidget(
              text: data.name ?? data.title ?? '',
              style: movieTitleStyle,
              margin: const EdgeInsets.only(top: 10),
              maxLines: 2,
            ),
            TextCustomWidget(
              text: data.firstAirDate ?? data.releaseDate ?? '',
              style: movieDateStyle,
              margin: const EdgeInsets.only(top: 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const CachedNetworkImageProvider(
            'https://image.tmdb.org/t/p/w500/tt79dbOPd9Z9ykEOpvckttgYXwH.jpg',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustomWidget(
            text: 'Welcome.',
            style: whiteTextStyle.copyWith(
              fontSize: 48,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextCustomWidget(
            text:
                'Millions of movies, TV shows and people to discover. Explore now.',
            style: whiteTextStyle.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFieldCustomWidget(
            margin: const EdgeInsets.only(top: 20),
            hintText: 'Search...',
            controller: TextEditingController(),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
