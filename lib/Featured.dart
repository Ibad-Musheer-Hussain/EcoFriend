import 'package:ecofriend/Components/ProductSection.dart';
import 'package:ecofriend/Learn.dart';
import 'package:ecofriend/Profile_new.dart';
import 'package:ecofriend/functions/showScanOptions.dart';
import 'package:flutter/material.dart';

import 'package:ecofriend/Homescreen.dart';

class ItemScreen extends StatefulWidget {
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
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
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Try Featured Products",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ProductSection(
            backgroundColor: Color.fromARGB(255, 248, 219, 219),
            productName: "Nestle\nwater",
            description:
                "Nestle Water provides pure, refreshing hydration in eco-friendly packaging. Sourced responsibly, it reduces plastic waste and supports sustainable living.",
            imageUrl: 'lib/images/nestlew.png',
            bgLeft: Color.fromARGB(255, 30, 144, 155),
            height: 247,
          ),
          ProductSection(
            backgroundColor: Color.fromARGB(255, 255, 180, 100),
            productName: "Alpro\nAlmond",
            description:
                "Alpro Almond offers a 100% organic, plant-based option with sustainable sourcing. Enjoy guilt-free snacking with eco-friendly packaging that supports a greener planet.",
            imageUrl: 'lib/images/alpro2.png',
            bgLeft: Color.fromARGB(255, 249, 136, 5),
            height: 247,
          ),
          ProductSection(
            backgroundColor: Color.fromARGB(255, 100, 150, 80),
            productName: "Starbucks\nbottle",
            description:
                "Starbucks Bottle is reusable and eco-friendly, reducing single-use plastic waste. Made from sustainable materials, it’s perfect for a greener lifestyle on the go.",
            imageUrl: 'lib/images/s_bottle.png',
            bgLeft: Color.fromARGB(255, 38, 68, 20),
            height: 247,
          ),
          ProductSection(
            backgroundColor: Color.fromARGB(255, 240, 245, 150),
            productName: "Nestle\nfruita",
            description:
                "Nestle Fruita is packaged in 100% recyclable materials, promoting eco-friendly choices. Enjoy refreshing taste while contributing to a sustainable future with every sip.",
            imageUrl: 'lib/images/juice.png',
            bgLeft: Color.fromARGB(255, 221, 226, 37),
            height: 247,
          ),
          ProductSection(
            backgroundColor: Color.fromARGB(255, 255, 153, 204),
            productName: "Nutela\nchocolate",
            description:
                "Nutella Chocolate is crafted with responsibly sourced ingredients and packaged in eco-friendly materials. Indulge in delicious taste while supporting sustainable practices.",
            imageUrl: 'lib/images/nutela.png',
            bgLeft: Color.fromARGB(255, 243, 86, 149),
            height: 247,
          ),
          ProductSection(
            backgroundColor: Color.fromARGB(255, 255, 180, 100),
            productName: "Coca-Cola",
            description:
                "Coca-Cola is committed to sustainability with 100% recyclable packaging. Enjoy the classic taste while supporting eco-friendly initiatives and reducing plastic waste.",
            imageUrl: 'lib/images/cocac.png',
            bgLeft: Color.fromARGB(255, 249, 136, 5),
            height: 305,
          ),
        ],
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
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.shopping_bag,
                color: Color.fromARGB(255, 243, 86, 149),
              ),
            ),
            label: 'Featured',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.shopping_bag,
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
              child: Icon(Icons.person),
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
