import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab1Screen extends StatefulWidget {
   const Tab1Screen({super.key});

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
   @override
   Widget build(BuildContext context) {
     super.build(context);

    final newsService = Provider.of<NewsService>(context);

      return Scaffold(
         body: newsService.headlines.isNotEmpty ? 
         NewsList(news: newsService.headlines) : 
         const Center(child: CircularProgressIndicator(),
         ),
      );
   }
   
     @override
     bool get wantKeepAlive => true;
}