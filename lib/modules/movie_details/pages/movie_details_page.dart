import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/app/data/models/payloads/response/res_movie_details/res_movie_details.dart';
import 'package:tmdb/modules/movie_details/providers/movie_details_provider.dart';
import 'package:tmdb/shared/themes/colors.dart';
import 'package:tmdb/shared/themes/texts.dart';
import 'package:tmdb/shared/values/constants.dart';
import 'package:tmdb/shared/widgets/image_network_custom_widget.dart';
import 'package:tmdb/shared/widgets/text_custom_widget.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsProvider(context),
      builder: (context, child) => const MovieDetailsView(),
    );
  }
}

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({super.key});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<MovieDetailsProvider>().init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: whiteColor,
      body: Consumer<MovieDetailsProvider>(
        builder: (context, value, child) {
          if (value.state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return value.state.movieDetailsOrFailureOption.fold(
            () => const Center(
              child: CircularProgressIndicator(),
            ),
            (a) => a.fold(
              (l) => Center(
                child: TextCustomWidget(text: l.message ?? ''),
              ),
              (r) => _buildWidget(value, r),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWidget(
    MovieDetailsProvider value,
    ResMovieDetails movieDetails,
  ) {
    final movie = value.state.movie;
    final genres = movieDetails.genres?.map((e) => e.name).join(', ');
    final createdBy = movieDetails.createdBy?.map((e) => e.name).join(', ');

    return ListView(
      children: [
        Container(
          color: primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 230,
                child: Stack(
                  children: [
                    ImageNetworkCustomWidget(
                      width: double.infinity,
                      imageUrl: '$imageBaseUrl${movie.backdropPath}',
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ImageNetworkCustomWidget(
                        width: 95,
                        height: 140,
                        imageUrl: '$imageBaseUrl${movie.posterPath}',
                        borderRadius: BorderRadius.circular(10),
                        margin: const EdgeInsets.only(left: 20),
                      ),
                    ),
                  ],
                ),
              ),
              TextCustomWidget(
                width: double.infinity,
                alignment: Alignment.center,
                text: movie.name ?? movie.title ?? '',
                style: whiteTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                margin: const EdgeInsets.symmetric(vertical: 15),
              ),
              Container(
                width: double.infinity,
                color: darkPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: greyNeutral30Color),
                      ),
                      child: TextCustomWidget(
                        text: 'TV-PG',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextCustomWidget(
                      text: genres ?? '',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      margin: const EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
              ),
              TextCustomWidget(
                text: movieDetails.tagline ?? '',
                style: greyTextStyle.copyWith(
                  fontSize: 18,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 25),
              ),
              TextCustomWidget(
                text: 'Overview',
                style: whiteTextStyle.copyWith(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              ),
              TextCustomWidget(
                text: movieDetails.overview ?? '',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(bottom: 25),
              ),
              TextCustomWidget(
                text: createdBy ?? '',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
              ),
              TextCustomWidget(
                text: 'Creator',
                style: whiteTextStyle.copyWith(fontSize: 14),
                margin: const EdgeInsets.symmetric(horizontal: 24),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
        _seriesCastWidget(value),
      ],
    );
  }

  Widget _seriesCastWidget(MovieDetailsProvider value) {
    return value.state.castOrFailureOption.fold(
      () => const Center(
        child: CircularProgressIndicator(),
      ),
      (either) => either.fold(
        (l) => Center(
          child: TextCustomWidget(text: l.message ?? ''),
        ),
        (r) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustomWidget(
              text: 'Series Cast',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            SizedBox(
              height: 250,
              child: MasonryGridView.count(
                shrinkWrap: true,
                crossAxisCount: 1,
                scrollDirection: Axis.horizontal,
                itemCount: r.cast?.length ?? 0,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                itemBuilder: (context, index) {
                  final e = r.cast?[index];

                  return Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ImageNetworkCustomWidget(
                          width: double.infinity,
                          height: 140,
                          imageUrl: '$imageBaseUrl${e?.profilePath}',
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustomWidget(
                                text: e?.name ?? '',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                margin: const EdgeInsets.only(top: 10),
                              ),
                              TextCustomWidget(
                                text: e?.character ?? '',
                                style: blackTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                margin: const EdgeInsets.only(top: 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
