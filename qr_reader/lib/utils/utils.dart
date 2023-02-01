import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchUrl(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipo == 'http') {
    if (!await canLaunchUrlString(url)) {
      throw 'Could not launch $url';
    } else {
      await launchUrlString(url);
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
