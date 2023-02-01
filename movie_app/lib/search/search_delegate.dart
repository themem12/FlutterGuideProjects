import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MovieSearchDelegate extends SearchDelegate {
  List<Movie> searchResult = [];
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (searchResult.isNotEmpty) {
      return ListView.separated(
        itemCount: searchResult.length,
        itemBuilder: (_, index) {
          searchResult[index].heroId =
              'search-suggestion-${searchResult[index].id}';
          return Hero(
              tag: searchResult[index].heroId!,
              child: _MovieItem(movie: searchResult[index]));
        },
        separatorBuilder: (_, __) => const Divider(),
      );
    }
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      searchResult = [];
      return _getNoInfo();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);
    return StreamBuilder(
      stream: moviesProvider.suggestionsStream,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _getNoInfo();
        searchResult = snapshot.data!;
        return ListView.separated(
          itemCount: snapshot.data!.length,
          itemBuilder: (_, index) {
            snapshot.data![index].heroId =
                'search-suggestion-${snapshot.data![index].id}';
            return Hero(
                tag: snapshot.data![index].heroId!,
                child: _MovieItem(movie: snapshot.data![index]));
          },
          separatorBuilder: (_, __) => const Divider(),
        );
      },
    );
  }

  Center _getNoInfo() {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 130,
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: NetworkImage(movie.fullPosterImg),
          placeholder: const AssetImage('assets/no-image.jpg'),
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
