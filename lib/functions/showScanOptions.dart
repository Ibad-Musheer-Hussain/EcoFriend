import 'package:ecofriend/functions/GalleryBarcode.dart';
import 'package:ecofriend/functions/scanBarcode.dart';
import 'package:flutter/material.dart';

void showScanOptions(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Color.fromARGB(255, 243, 86, 149),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 150,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              title: Text(
                'Scan using Camera',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                scanBarcode(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo, color: Colors.white),
              title: Text(
                'Scan using Gallery',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                scanBarcodeFromGallery(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
