import 'package:ecofriend/Edit_profile.dart';
import 'package:ecofriend/History.dart';
import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Learn.dart';
import 'package:ecofriend/Featured.dart';
import 'package:ecofriend/Objects/JSONData.dart';
import 'package:ecofriend/Password.dart';
import 'package:ecofriend/functions/Logout.dart';
import 'package:ecofriend/functions/showScanOptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class MyProfileScreen2 extends StatefulWidget {
  @override
  State<MyProfileScreen2> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen2> {
  int _selectedIndex = 0;
  String barcodeResult = 'No scan yet';
  late JsonStorage _jsonStorage;
  late String name;
  late String id;
  late String email;
  late int age;
  late String location;
  late String language;
  late String gender;

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

  @override
  void initState() {
    super.initState();

    final box = Hive.box('UserInfo');
    _jsonStorage = JsonStorage(box);
    _jsonStorage = JsonStorage(box);
    final Map<dynamic, dynamic>? _UserProfile = _jsonStorage.getJsonData();
    id = _UserProfile?['id'] ?? _UserProfile?['user']?['id'];
    email = _UserProfile?['email'] ?? _UserProfile?['user']?['email'];
    name = _UserProfile?['name'] ?? _UserProfile?['user']?['name'];
    age = _UserProfile?['age'] ?? _UserProfile?['user']?['age'];
    location = _UserProfile?['location'] ?? _UserProfile?['user']?['location'];
    language = _UserProfile?['language'] ?? _UserProfile?['user']?['language'];
    gender = _UserProfile?['gender'] ?? _UserProfile?['user']?['gender'];

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'My Profile',
            style: TextStyle(
              fontFamily: "CenturyGothic",
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
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
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('lib/images/profile.jpg'),
                          ),
                          Container(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'CenturyGothic',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  id,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 7,
                                    fontFamily: 'CenturyGothic',
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                leading: Icon(
                  Icons.account_circle,
                  size: 32,
                ),
                title: Text("Profile Details"),
                subtitle: Text("Review your information"),
                trailing: Icon(Icons.arrow_forward),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History()));
                },
                leading: Icon(
                  Icons.history,
                  size: 32,
                ),
                title: Text("History"),
                subtitle: Text("View previous searches"),
                trailing: Icon(Icons.arrow_forward),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Password()));
                },
                leading: Icon(
                  Icons.security,
                  size: 32,
                ),
                title: Text("Security"),
                subtitle: Text("Change password"),
                trailing: Icon(Icons.arrow_forward),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Logout(context);
                },
                leading: Icon(
                  Icons.logout,
                  size: 32,
                ),
                title: Text("Log out"),
                trailing: Icon(Icons.arrow_forward),
              ),
              SizedBox(
                height: 10,
              ),
            ],
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
