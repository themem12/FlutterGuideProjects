import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/themes/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  const NewsList({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return _NewCard(article: news[index], index: index);
      },
    );
  }
}

class _NewCard extends StatelessWidget {

  final Article article;
  final int index;

  const _NewCard({required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(article: article, index: index,),
        _CardTitle(article: article),
        _CardImage(article: article),
        _CardBody(article: article),
        const SizedBox(height: 10,),
        const _CardFooter(),
        const SizedBox(height: 10,),
        const Divider(thickness: 2,)
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {

  final Article article;
  final int index;
  
  const _CardTopBar({
    required this.article, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text('$index ', style: TextStyle(color: myTheme.colorScheme.secondary),),
          Text(article.source.name,)
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article article;
  const _CardTitle({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(article.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article article;
  const _CardImage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: article.urlToImage != null ?
          FadeInImage(
            image: NetworkImage(article.urlToImage ?? ''),
            placeholder: const AssetImage('assets/giphy.gif'),
          ) : const Image(image: AssetImage('assets/no-image.png')),
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article article;
  const _CardBody({required this.article});

  @override
  Widget build(BuildContext context) {
    return Text(article.description ?? '');
  }
}

class _CardFooter extends StatelessWidget {
  const _CardFooter();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.star_border),
        ),
        const SizedBox(width: 10,),
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.share),
        ),
      ],
    );
  }
}