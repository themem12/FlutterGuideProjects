import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/directions_screen.dart';
import 'package:qr_reader/screens/maps_screen.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import '../widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteScans();
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: const _HomeScreenBody(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavigatorBar(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanlListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanlListProvider.selectedType = 'geo';
        scanlListProvider.loadScansByType('geo');
        return const MapsScreen();
      case 1:
        scanlListProvider.selectedType = 'http';
        scanlListProvider.loadScansByType('http');
        return const DirectionsScreen();
      default:
        return const MapsScreen();
    }
  }
}
