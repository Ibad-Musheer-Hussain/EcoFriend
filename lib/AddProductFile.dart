import 'dart:io';
import 'package:ecofriend/Featured.dart';
import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Learn.dart';
import 'package:ecofriend/Profile_new.dart';
import 'package:ecofriend/TextRecog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Addproductfile extends StatefulWidget {
  const Addproductfile({super.key, required this.barcode});
  final String barcode;

  @override
  State<Addproductfile> createState() => _AddproductfileState();
}

class _AddproductfileState extends State<Addproductfile> {
  String titleURL = "";
  File? _image;
  double aspectRatio = 16 / 9;
  int _selectedIndex = 0;
  TextEditingController _controller = TextEditingController();
  String email = "Product Name";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset(0.0, 0.0);
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemScreen(),
          ),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LearnScreen(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyProfileScreen2(),
          ),
        );
        break;
    }
  }

  Future<String> _uploadImages() async {
    try {
      Reference titleStorageReference = FirebaseStorage.instance
          .ref()
          .child('Product Pics/${DateTime.now()}_${_image}.png');

      UploadTask titleUploadTask = titleStorageReference.putFile(
        _image!,
        SettableMetadata(contentType: 'image/png'),
      );
      await titleUploadTask;
      String url = await titleStorageReference.getDownloadURL();
      titleURL = url;
      print('Title image URL: $titleURL');
    } catch (e) {
      print('Error uploading images: $e');
    }
    return handleUploadCompletion();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
    Navigator.pop(context);
  }

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
                  _pickImage(ImageSource.camera);
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
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String handleUploadCompletion() {
    String ad = titleURL;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Images uploaded',
        style: TextStyle(color: Color(0xFFDDE255)),
      ),
      backgroundColor: Color.fromARGB(255, 38, 68, 20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      duration: Duration(seconds: 4),
    ));
    return ad;
  }

  void _openFullSizeImage(File image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / aspectRatio,
            child: Image.file(
              image,
              fit: BoxFit.fill,
            ),
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
          title: Text("Create Product",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Color(0xFFDDE255),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Add Product Image",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _image == null
                      ? GestureDetector(
                          onTap: () {
                            ProductShowOptions(context);
                          },
                          child: Image.asset(
                            'lib/images/download.png',
                            width: MediaQuery.of(context).size.width - 120,
                            height:
                                MediaQuery.of(context).size.width / aspectRatio,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _openFullSizeImage(_image!);
                          },
                          onLongPress: () {
                            ProductShowOptions(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.file(
                              _image!,
                              width: MediaQuery.of(context).size.width - 100,
                              height: MediaQuery.of(context).size.width /
                                  aspectRatio,
                              fit: BoxFit.fill,
                            ),
                          )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 32.0, top: 32, right: 32, bottom: 20),
                      child: Text(
                        "Product Name",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 38, 68, 20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 38, 68, 20)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        isDense: true,
                        hintText: 'Enter product name',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton.extended(
                      backgroundColor: Color.fromARGB(255, 38, 68, 20),
                      onPressed: () {
                        Future<String> uploadImagesFuture = _uploadImages();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Imagescan(
                              uploadImagesFuture: uploadImagesFuture,
                              Name: _controller.text.toString(),
                              barcode: widget.barcode,
                            ),
                          ),
                        );
                      },
                      label: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text("Continue",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDDE255))),
                      )),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  Icons.home,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(Icons.shopping_bag),
              ),
              label: 'Featured',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  Icons.lightbulb,
                  color: Colors.transparent,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(Icons.lightbulb),
              ),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.person,
                ),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ));
  }
}
