import 'package:ecofriend/Featured.dart';
import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Learn.dart';
import 'package:ecofriend/Profile_new.dart';
import 'package:ecofriend/functions/showScanOptions.dart';
import 'package:ecofriend/item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<dynamic> history = [];
  int _selectedIndex = 0;
  bool _isLoading = true;
  List<Color> backgroundColors = [
    Color.fromARGB(255, 248, 219, 219),
    Color.fromARGB(255, 255, 255, 220),
    Color.fromARGB(255, 255, 222, 179),
    Color.fromARGB(255, 198, 218, 180),
    Color.fromARGB(255, 248, 219, 219),
  ];

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    var box = await Hive.openBox('history');
    history = box.get('history') ?? [];
    setState(() {
      _isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Item History"),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: _isLoading
            ? Text("Your history is empty. Try searching for new products")
            : ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  Item historyitem = history[index];
                  String packagingText =
                      historyitem.getPackagingTextList.join(', ');
                  Color cardColor =
                      backgroundColors[index % backgroundColors.length];
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      color: cardColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: 250,
                                maxHeight: 280,
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2 - 50,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  historyitem.image_url,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  historyitem.brand,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(historyitem.categoriesText
                                    .split(',')
                                    .first),
                                const SizedBox(height: 8),
                                const Text(
                                  "Nutriscore:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(historyitem.nutriscore),
                                const SizedBox(height: 8),
                                const Text(
                                  "Ecoscore:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(historyitem.ecoscore),
                                const SizedBox(height: 8),
                                const Text(
                                  "Packaging Material:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 70,
                                  child: Text(
                                    packagingText,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            showScanOptions(context);
          },
          backgroundColor: const Color.fromARGB(255, 243, 86, 149),
          child: const Icon(Icons.qr_code_scanner, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
