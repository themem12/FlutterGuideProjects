import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
   const Tab2Screen({super.key});

   @override
   Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);
      return SafeArea(
        child: Scaffold(
           body: Column(
            children: [
              const _CategoryList(),
              Expanded(
                child: NewsList(news: newService.getSelectedCategoryArticles ?? []),
              )
            ],
           )
        ),
      );
   }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(category: categories[index]),
                const SizedBox(height: 5,),
                Text('${categories[index].name[0].toUpperCase()}${categories[index].name.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.category,
  });

  final NewsCategory category;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: newsService.selectedCategory == category.name ? Colors.redAccent : Colors.white
        ),
        child: Icon(
          category.icon,
          color: newsService.selectedCategory == category.name ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
}