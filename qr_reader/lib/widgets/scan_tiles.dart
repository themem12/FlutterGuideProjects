import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  final String type;
  const ScanTiles({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direction) {
            scanListProvider.deleteScanById(scanListProvider.scans[index].id!);
          },
          child: ListTile(
            leading: Icon(
              type == 'http' ? Icons.home_outlined : Icons.map_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scanListProvider.scans[index].valor),
            subtitle: Text(scanListProvider.scans[index].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => launchUrl(context, scanListProvider.scans[index]),
          ),
        );
      },
    );
  }
}
