import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image; // Store the selected image
  final picker = ImagePicker(); // Image picker instance
  String? _responseText; // Variable to store the server response

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _responseText =
            null; // Clear previous response when a new image is selected
      } else {
        _responseText = 'No image selected.';
      }
    });
  }

  // Function to upload image to Flask server
  Future<void> _uploadImage() async {
    if (_image == null) return;

    final uri = Uri.parse(
        'https://luckily-warm-chimp.ngrok-free.app/predict'); // Your server's URL
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        setState(() {
          _responseText = 'Response: $responseData';
        });
      } else {
        setState(() {
          _responseText =
              'Failed to upload image. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseText = 'Error uploading image: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image to Flask Server'),
      ),
      body: Center(
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text('Upload Image'),
              ),
              const SizedBox(height: 20),
              _responseText != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _responseText!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    )
                  : Container(),
            ],
          ),
        ]),
      ),
    );
  }
}
