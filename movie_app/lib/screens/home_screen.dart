import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/search/search_delegate.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MovieSearchDelegate());
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvider.onDisplayMovies,
            ),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares!',
              onNextPage: () {
                moviesProvider.getPopularMovies();
              },
            ),
            MovieSlider(
              movies: moviesProvider.topRatedMovies,
              title: 'Aclamadas por los usuarios!',
              onNextPage: () {
                moviesProvider.getTopRatedMovies();
              },
            ),
            MovieSlider(
              movies: moviesProvider.upcomingMovies,
              title: 'Proximamente!',
              onNextPage: () {
                moviesProvider.getUpcomingMovies();
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
