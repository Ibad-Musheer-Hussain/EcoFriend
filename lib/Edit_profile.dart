import 'package:ecofriend/Components/ProfileInfoRow.dart';
import 'package:ecofriend/Featured.dart';
import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Learn.dart';
import 'package:ecofriend/Objects/JSONData.dart';
import 'package:ecofriend/Profile_new.dart';
import 'package:ecofriend/functions/EditUser.dart';
import 'package:ecofriend/functions/showScanOptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int _selectedIndex = 0;
  bool _isEditingEnabled = false;
  String barcodeResult = 'No scan yet';
  late JsonStorage _jsonStorage;
  late String name;
  late String id;
  late String email;
  late int age;
  late String location;
  late String language;
  late String gender;

  @override
  void initState() {
    super.initState();
    final box = Hive.box('UserInfo');
    _jsonStorage = JsonStorage(box);
    Map<dynamic, dynamic>? _UserProfile =
        Map<dynamic, dynamic>.from(_jsonStorage.getJsonData());

    id = _UserProfile['id'] ?? _UserProfile['user']?['id'];
    email = _UserProfile['email'] ?? _UserProfile['user']?['email'];
    name = _UserProfile['name'] ?? _UserProfile['user']?['name'];
    age = _UserProfile['age'] ?? _UserProfile['user']?['age'];
    location = _UserProfile['location'] ?? _UserProfile['user']?['location'];
    language = _UserProfile['language'] ?? _UserProfile['user']?['language'];
    gender = _UserProfile['gender'] ?? _UserProfile['user']?['gender'];
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

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
                HomeScreen(),
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

  void _toggleEditing() {
    setState(() {
      _isEditingEnabled = !_isEditingEnabled;

      if (!_isEditingEnabled) {
        updateUser(id, email, name, age, location, language, gender, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              fontFamily: "CenturyGothic",
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditingEnabled ? Icons.check : Icons.edit,
              color: Color.fromARGB(255, 243, 86, 149),
            ),
            onPressed: () {
              _toggleEditing();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              color: Color.fromARGB(255, 248, 219, 219),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ProfileInfoRow(
                      icon: Icons.email_outlined,
                      color: Color.fromARGB(255, 243, 86, 149),
                      title: 'Name',
                      value: name,
                      onValueChanged: (String value) {
                        name = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10,
                        thickness: 1,
                        color: Color.fromARGB(255, 248, 219, 219)),
                    ProfileInfoRow(
                      icon: Icons.email_outlined,
                      color: Color.fromARGB(255, 243, 86, 149),
                      title: 'Email',
                      value: email,
                      onValueChanged: (String value) {
                        email = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10,
                        thickness: 1,
                        color: Color.fromARGB(255, 248, 219, 219)),
                    ProfileInfoRow(
                      icon: Icons.hourglass_empty_rounded,
                      title: 'Age',
                      color: Color.fromARGB(255, 243, 86, 149),
                      value: age.toString(),
                      onValueChanged: (String value) {
                        int parsedAge = int.parse(value);
                        if (parsedAge > 09 && parsedAge < 99) {
                          age = parsedAge;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Please enter a valid number for age.'),
                            ),
                          );
                        }
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10,
                        thickness: 1,
                        color: Color.fromARGB(255, 248, 219, 219)),
                    ProfileInfoRow(
                      icon: Icons.person_outline,
                      title: 'Gender',
                      color: Color.fromARGB(255, 243, 86, 149),
                      value: gender,
                      onValueChanged: (String value) {
                        gender = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10,
                        thickness: 1,
                        color: Color.fromARGB(255, 248, 219, 219)),
                    ProfileInfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      color: Color.fromARGB(255, 243, 86, 149),
                      value: location,
                      onValueChanged: (String value) {
                        location = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10,
                        thickness: 1,
                        color: Color.fromARGB(255, 248, 219, 219)),
                    ProfileInfoRow(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      color: Color.fromARGB(255, 243, 86, 149),
                      value: language,
                      onValueChanged: (String value) {
                        language = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            showScanOptions(context);
          },
          backgroundColor: Color.fromARGB(255, 243, 86, 149),
          child: const Icon(Icons.qr_code_scanner, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.home,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(Icons.shopping_bag),
            ),
            label: 'Featured',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.lightbulb,
                color: Colors.transparent,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(Icons.lightbulb),
            ),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.person,
                color: Color.fromARGB(255, 243, 86, 149),
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
      ),
    );
  }
}
