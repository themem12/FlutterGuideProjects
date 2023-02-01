import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/scan_model.dart';
import '../providers/db_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        final barcodeScanRes = 'https://www.saaveguillermo.com';
        final tempScan = ScanModel(valor: 'http://google.com');
        DBProvider.db.deleteAllScans().then((value) => print(value));
        print(barcodeScanRes);
      },
      child: const Icon(Icons.qr_code),
    );
  }
}
