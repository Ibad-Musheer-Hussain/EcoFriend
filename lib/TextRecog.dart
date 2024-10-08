import 'package:ecofriend/FinishProduct.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class Imagescan extends StatefulWidget {
  const Imagescan(
      {super.key,
      required this.uploadImagesFuture,
      required this.Name,
      required this.barcode});
  final Future<String> uploadImagesFuture;
  final String Name;
  final String barcode;

  @override
  State<Imagescan> createState() => _ImagescanState();
}

class _ImagescanState extends State<Imagescan> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  double aspectRatio = 16 / 9;
  String cleanedText = '';
  List<String> commonIngredients = [];
  List<String> ingredientsList = [];
  TextEditingController _controller = TextEditingController();

  void ProductShowOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xFFDDE255),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Color.fromARGB(255, 38, 68, 20),
                ),
                title: Text(
                  'Scan using Camera',
                  style: TextStyle(color: Color.fromARGB(255, 38, 68, 20)),
                ),
                onTap: () {
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.photo, color: Color.fromARGB(255, 38, 68, 20)),
                title: Text(
                  'Scan using Gallery',
                  style: TextStyle(color: Color.fromARGB(255, 38, 68, 20)),
                ),
                onTap: () {
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Get Ingredients",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Color(0xFFDDE255),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Fetch Ingredients from Image",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  GestureDetector(
                    onTap: () {
                      ProductShowOptions(context);
                    },
                    child: Image.asset(
                      'lib/images/download.png',
                      width: MediaQuery.of(context).size.width - 120,
                      height: MediaQuery.of(context).size.width / aspectRatio,
                    ),
                  ),
                if (imageFile != null)
                  Image.file(
                    File(imageFile!.path),
                    height: 200,
                    width: 300,
                    fit: BoxFit.fill,
                  ),
                SizedBox(
                  height: 30,
                ),
                FloatingActionButton.extended(
                    heroTag: "asd",
                    backgroundColor: Color.fromARGB(255, 38, 68, 20),
                    onPressed: () {
                      ProductShowOptions(context);
                    },
                    label: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text("Select Image",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFDDE255))),
                    )),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      "Ingredient List",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 38, 68, 20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 38, 68, 20)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(24.0),
                //   child: Text.rich(
                //     TextSpan(
                //       children: ingredientsList.asMap().entries.map((entry) {
                //         int index = entry.key;
                //         String ingredient = entry.value;
                //         bool isCommon = commonIngredients.contains(ingredient);
                //         String separator =
                //             (index == ingredientsList.length - 1) ? '.' : ', ';
                //         return TextSpan(
                //           text: '$ingredient$separator',
                //           style: TextStyle(
                //             fontSize: 20,
                //             color: isCommon ? Colors.red : Colors.black,
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 40),
                FloatingActionButton.extended(
                    backgroundColor: Color.fromARGB(255, 38, 68, 20),
                    onPressed: () {
                      if (imageFile != null && scannedText != "") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinishProduct(
                              Name: widget.Name,
                              uploadImagesFuture: widget.uploadImagesFuture,
                              ingredients: scannedText,
                              barcode: widget.barcode,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Incomplete Information',
                            style: TextStyle(color: Color(0xFFDDE255)),
                          ),
                          backgroundColor: Color.fromARGB(255, 38, 68, 20),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          duration: Duration(seconds: 4),
                        ));
                      }
                    },
                    label: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text("Continue",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFDDE255))),
                    )),
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
    cropImage();
    Navigator.pop(context);
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

      scannedText = scannedText.replaceFirst('INGREDIENTS: ', '');

      print("Printing Scanned Text on console");
      print(scannedText);
      _controller.text = scannedText;

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
