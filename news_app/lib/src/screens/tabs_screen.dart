import 'package:flutter/material.dart';
import 'package:news_app/src/screens/screens.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
   const TabsScreen({super.key});

   @override
   Widget build(BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => _NavegationModel(),
        child: const Scaffold(
           body: _Screens(),
           bottomNavigationBar: _NavegationBar(),
        ),
      );
   }
}

class _NavegationBar extends StatelessWidget {
  const _NavegationBar();

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavegationModel>(context);
    return BottomNavigationBar(
      currentIndex: navigationModel.actualScreen,
      onTap: (index) => navigationModel.actualScreen = index,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: 'Para ti' ),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezado' ),
      ],
    );
  }
}

class _Screens extends StatelessWidget {
  const _Screens();

  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavegationModel>(context);
    return PageView(
      controller: navegationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
         Tab1Screen(),
 
         Tab2Screen(),
      ],
    );
  }
}

class _NavegationModel with ChangeNotifier {
  int _actualScreen = 0;

  final PageController _pageController = PageController();

  int get actualScreen => _actualScreen;

  PageController get pageController => _pageController;

  set actualScreen(int value) {
    _actualScreen = value;

    _pageController.animateToPage(value, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners();
  }
}