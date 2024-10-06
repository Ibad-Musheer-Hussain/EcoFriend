import 'package:ecofriend/Components/ProfileInfoRow.dart';
import 'package:ecofriend/Featured.dart';
import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Learn.dart';
import 'package:ecofriend/Objects/JSONData.dart';
import 'package:ecofriend/Profile_new.dart';
import 'package:ecofriend/functions/Changepass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  int _selectedIndex = 0;
  bool _isEditingEnabled = true;
  String barcodeResult = 'No scan yet';
  late JsonStorage _jsonStorage;
  String password = '';
  String newpass = '';
  String repass = '';
  late String id;

  @override
  void initState() {
    super.initState();
    final box = Hive.box('UserInfo');
    _jsonStorage = JsonStorage(box);
    Map<dynamic, dynamic>? _UserProfile =
        Map<dynamic, dynamic>.from(_jsonStorage.getJsonData());

    id = _UserProfile['id'] ?? _UserProfile['user']?['id'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Edit Password',
            style: TextStyle(
              fontFamily: "CenturyGothic",
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              color: Color.fromARGB(255, 221, 226, 85),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ProfileInfoRow(
                      icon: Icons.email_outlined,
                      title: 'Enter Current Password',
                      color: Color.fromARGB(255, 38, 68, 20),
                      value: password,
                      onValueChanged: (String value) {
                        password = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10, thickness: 1, color: Colors.transparent),
                    ProfileInfoRow(
                      icon: Icons.email_outlined,
                      title: 'New Password',
                      color: Color.fromARGB(255, 38, 68, 20),
                      value: newpass,
                      onValueChanged: (String value) {
                        newpass = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10, thickness: 1, color: Colors.transparent),
                    ProfileInfoRow(
                      icon: Icons.hourglass_empty_rounded,
                      title: 'Retype Password',
                      color: Color.fromARGB(255, 38, 68, 20),
                      value: repass,
                      onValueChanged: (String value) {
                        repass = value;
                      },
                      isEditingEnabled: _isEditingEnabled,
                    ),
                    Divider(
                        height: 10, thickness: 1, color: Colors.transparent),
                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 38, 68, 20))),
                          onPressed: () {
                            print(id);
                            print(password);
                            print(newpass);
                            updatepass(id, password, newpass);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Change Password",
                                style: TextStyle(
                                  fontFamily: "CenturyGothic",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 221, 226, 85),
                                )),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
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
