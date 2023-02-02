import 'package:flutter/material.dart';
import 'package:preferences_app/providers/theme_provider.dart';
import 'package:preferences_app/share_preferences/preferences.dart';
import 'package:preferences_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = 'Settings';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // bool isDarkmode = Preferences.isDarkmode;
  // int gender = 1;
  // String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(0.8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ajustes',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.w300),
              ),
              const Divider(),
              SwitchListTile.adaptive(
                value: Preferences.isDarkmode,
                title: const Text('Darkmode'),
                onChanged: (value) {
                  Preferences.isDarkmode = value;
                  final themeProvider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  value
                      ? themeProvider.setDarkmode()
                      : themeProvider.setLightmode();
                  setState(() {});
                },
              ),
              const Divider(),
              RadioListTile<int>(
                title: const Text('Masculino'),
                value: 1,
                groupValue: Preferences.gender,
                onChanged: (value) {
                  Preferences.gender = value ?? 1;
                  setState(() {});
                },
              ),
              const Divider(),
              RadioListTile<int>(
                title: const Text('Femenino'),
                value: 2,
                groupValue: Preferences.gender,
                onChanged: (value) {
                  Preferences.gender = value ?? 1;
                  setState(() {});
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  initialValue: Preferences.name,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    helperText: 'Nombre del usuario',
                  ),
                  onChanged: (value) {
                    Preferences.name = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
