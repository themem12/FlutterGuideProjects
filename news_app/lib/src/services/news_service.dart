import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final _urlNews = 'https://newsapi.org/v2';
  final _apiKey = 'a90a4b837dae4ba68b0f4dc54b8efb28';
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<NewsCategory> categories = [
    NewsCategory(FontAwesomeIcons.building, 'business'),
    NewsCategory(FontAwesomeIcons.tv, 'entertainment'),
    NewsCategory(FontAwesomeIcons.addressCard, 'general'),
    NewsCategory(FontAwesomeIcons.headSideVirus, 'health'),
    NewsCategory(FontAwesomeIcons.vials, 'science'),
    NewsCategory(FontAwesomeIcons.volleyball, 'sports'),
    NewsCategory(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    for (var category in categories) {
      categoryArticles[category.name] = [];
    }

    getArticlesByCategory(_selectedCategory);
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;

    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article>? get getSelectedCategoryArticles => categoryArticles[_selectedCategory];

  getTopHeadlines() async {
    final url = '$_urlNews/top-headlines?country=mx&apiKey=$_apiKey';
    final response = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromRawJson(response.body);

    headlines.addAll(newsResponse.articles);
    
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if((categoryArticles[category]?.length ?? 0) < 0) {
      return categoryArticles[category];
    }
    final url = '$_urlNews/top-headlines?country=mx&apiKey=$_apiKey&category=$category';
    final response = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromRawJson(response.body);

    categoryArticles[category]?.addAll(newsResponse.articles);
    
    notifyListeners();
  }
}