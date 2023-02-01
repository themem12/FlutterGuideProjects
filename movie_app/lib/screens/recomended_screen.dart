import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class RecomendedScreen extends StatelessWidget {
  const RecomendedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context)!.settings.arguments as int;
    final MoviesProvider moviesProvider =
        Provider.of<MoviesProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: const Text('Películas similares')),
        body: FutureBuilder(
          future: moviesProvider.getRecomendedMovies(movieId),
          builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 20),
              );
            }
            final movies = snapshot.data ?? [];
            return Container(
                margin: const EdgeInsets.only(
                    bottom: 30, left: 10, right: 10, top: 20),
                width: double.infinity,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      mainAxisExtent: 180,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final Movie movie = movies[index];
                    movie.heroId = 'recomended-${movie.id}';
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, 'details',
                              arguments: movie),
                          child: Hero(
                            tag: movie.heroId!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                placeholder:
                                    const AssetImage('assets/no-image.jpg'),
                                image:
                                    NetworkImage(movies[index].fullPosterImg),
                                height: 120,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          movies[index].title,
                          maxLines: 2,
                        ),
                      ],
                    );
                  },
                ));
          },
        ));
  }
}
