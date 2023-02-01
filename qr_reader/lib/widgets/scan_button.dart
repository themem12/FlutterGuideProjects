import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        // const barcodeScanRes = 'https://www.saaveguillermo.com';
        // const barcodeScanRes = 'geo:19.33598796431982, -99.17858005692497';
        if (barcodeScanRes == '-1') return;
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        await scanListProvider
            .newScan(barcodeScanRes)
            .then((value) => launchUrl(context, value));
      },
      child: const Icon(Icons.qr_code),
    );
  }
}
