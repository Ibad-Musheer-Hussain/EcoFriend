import 'package:ecofriend/functions/showProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<void> scanBarcode(BuildContext context) async {
  String _scannedBarcode = "";
  try {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    _scannedBarcode =
        barcodeScanResult == "-1" ? "90162602" : barcodeScanResult;
    showProductDetails(context, _scannedBarcode);
  } catch (e) {
    print("shits fked");
  }
}
