import 'dart:async';
import 'dart:io';
import 'package:ecofriend/functions/showProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

Future<void> scanBarcodeFromGallery(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  void showCustomSnackBar(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    Navigator.pop(context);

    Timer(Duration(milliseconds: 500), () {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: Duration(seconds: 4),
          content: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 86, 149),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'No Barcode Detected.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    });
  }

  if (image != null) {
    final File imageFile = File(image.path);

    final inputImage = InputImage.fromFile(imageFile);
    final barcodeScanner = BarcodeScanner();

    try {
      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      final String barcodeValue =
          barcodes.isNotEmpty ? barcodes.first.rawValue ?? '-1' : '-1';

      if (int.tryParse(barcodeValue)! > 1000) {
        showProductDetails(context, barcodeValue);
      } else {
        showCustomSnackBar(context);
      }
    } catch (e) {
    } finally {
      barcodeScanner.close();
    }
  } else {}
}
