import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
              movieTitle: movie.title, backdropPath: movie.fullbackdropPath),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(
              moviePoster: movie.fullPosterImg,
              originalTitle: movie.originalTitle,
              voteAverage: movie.voteAverage.toString(),
              movieTitle: movie.title,
              movieId: movie.heroId!,
            ),
            _Overview(overviewText: movie.overview),
            const SizedBox(
              height: 20,
            ),
            CastingCards(
              movieId: movie.id,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'recomended',
                      arguments: movie.id);
                },
                child: const SizedBox(
                  child: Center(child: Text('Películas similares')),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String movieTitle;
  final String backdropPath;
  const _CustomAppBar({required this.movieTitle, required this.backdropPath});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black26,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(
            movieTitle,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  final String originalTitle;
  final String voteAverage;
  final String movieId;
  const _PosterAndTitle(
      {required this.movieTitle,
      required this.moviePoster,
      required this.originalTitle,
      required this.voteAverage,
      required this.movieId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Hero(
          tag: movieId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(moviePoster),
              height: 150,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width - 190),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                originalTitle,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border_outlined,
                    size: 15,
                    color: Colors.grey,
                  ),
                  Text(
                    voteAverage,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overviewText;
  const _Overview({required this.overviewText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        overviewText,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
