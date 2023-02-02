import 'package:flutter/material.dart';
import 'package:preferences_app/share_preferences/preferences.dart';
import 'package:preferences_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const SideMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('isDarkmode: ${Preferences.isDarkmode}'),
          const Divider(),
          Text('Género: ${Preferences.gender == 1 ? 'Masculino' : 'Femenino'}'),
          const Divider(),
          Text('Nombre del usuario: ${Preferences.name}'),
          const Divider(),
        ],
      ),
    );
  }
}
