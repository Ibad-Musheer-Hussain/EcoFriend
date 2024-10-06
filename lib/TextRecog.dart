import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class Imagescan extends StatefulWidget {
  const Imagescan({Key? key}) : super(key: key);

  @override
  State<Imagescan> createState() => _ImagescanState();
}

class _ImagescanState extends State<Imagescan> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  String cleanedText = '';
  List<String> commonIngredients = [];
  List<String> ingredientsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/barcode"); //WILL NOT WORK
              },
              icon: Icon(Icons.chevron_right))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null)
                  Image.file(
                    File(imageFile!.path),
                    height: 300,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: const Text("Pick Image from Gallery"),
                ),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: const Text("Pick Image from Camera"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (imageFile != null) {
                      cropImage();
                    }
                  },
                  child: const Text("Select Text"),
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: ingredientsList.asMap().entries.map((entry) {
                      int index = entry.key;
                      String ingredient = entry.value;
                      bool isCommon = commonIngredients.contains(ingredient);
                      String separator =
                          (index == ingredientsList.length - 1) ? '.' : ', ';

                      return TextSpan(
                        text: '$ingredient$separator',
                        style: TextStyle(
                          fontSize: 20,
                          color: isCommon ? Colors.yellow : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        setState(() {});
      }
    } catch (e) {
      setState(() {
        textScanning = false;
        imageFile = null;
        scannedText = "Error occurred while picking image";
      });
    }
  }

  Future<void> cropImage() async {
    if (imageFile == null) return;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: false,
          rotateButtonsHidden: true,
        ),
      ],
    );

    if (croppedFile != null) {
      imageFile = XFile(croppedFile.path);
      setState(() {
        textScanning = true;
      });
      getRecognisedText(File(imageFile!.path));
    }
  }

  void getRecognisedText(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();

    setState(() {
      scannedText = recognisedText.text.replaceAll('\n', ' ').trim();
      textScanning = false;
      print("Printing Scanned Text on console");
      print(scannedText);

      String cleanedText = scannedText.split('.').first.trim();

      cleanedText = cleanedText.replaceFirst('INGREDIENTS:', '').trim();
      scannedText = cleanedText
          .replaceAll('*', '')
          .replaceAll('\'', '')
          .replaceAll('\"', '')
          .trim();

      scannedText = scannedText.toUpperCase();

      ingredientsList = scannedText
          .split(',')
          .map((ingredient) => ingredient.trim())
          .toList();

      print("Ingredients List: $ingredientsList");

      // Convert target string into a list of strings
      List<String> targetIngredients = [
        "SUGAR",
        "SALT",
        "CORN SYRUP",
        "HIGH-FRUCTOSE CORN SYRUP",
        "HCFS",
        "ASPARTAME",
        "MSG"
            "PHOSPHATE",
        "NITRATE",
        "NITRITE",
        "BUTANE",
        "PROPANE",
        "METHANE"
            "ARSENIC",
        "PALM OIL"
      ];

      commonIngredients = ingredientsList
          .where((ingredient) =>
              targetIngredients.any((target) => ingredient.contains(target)))
          .toList();

      if (commonIngredients.isNotEmpty) {
        print("Common ingredients found: $commonIngredients");
      } else {
        print("No common ingredients found.");
      }
    });
  }
}
