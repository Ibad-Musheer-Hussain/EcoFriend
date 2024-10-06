import 'package:ecofriend/Profile_new.dart';
import 'package:ecofriend/functions/showScanOptions.dart';
import 'package:ecofriend/functions/showWeb.dart';
import 'package:flutter/material.dart';
import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Featured.dart';

class LearnScreen extends StatefulWidget {
  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
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
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Learn Something New",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            SizedBox(
              height: 10,
            ),
            BlogPostCard(
              title: 'Reduce Plastic Waste',
              description:
                  'Learn how to reduce plastic waste in everyday life.',
              imageUrl: 'lib/images/tip1.png',
              bg: Color.fromARGB(255, 248, 219, 219),
              url:
                  "https://www.quora.com/How-can-we-reduce-plastic-waste-at-home-and-school",
            ),
            SizedBox(height: 16),
            BlogPostCard(
                title: 'Sustainable Living Tips',
                description:
                    'Adopt a more sustainable lifestyle with these tips.',
                imageUrl: 'lib/images/tip2.png',
                bg: Color.fromARGB(255, 255, 255, 220),
                url:
                    "https://medium.com/@axaydevikar/10-sustainable-living-tips-for-reducing-your-carbon-footprint-6bbe7edd0f23"),
            SizedBox(height: 16),
            BlogPostCard(
              title: 'Eco-friendly Shopping',
              description:
                  'Explore how to make eco-conscious shopping decisions.',
              imageUrl: 'lib/images/tip3.png',
              bg: Color.fromARGB(255, 255, 222, 179),
              url:
                  "https://www.quora.com/How-can-I-make-my-grocery-shopping-more-eco-friendly",
            ),
            SizedBox(height: 16),
            BlogPostCard(
              title: 'Renewable Energy Sources',
              description:
                  'Discover the benefits of switching to renewable energy.',
              imageUrl: 'lib/images/tip4.png',
              bg: Color.fromARGB(255, 198, 218, 180),
              url:
                  "https://medium.com/drax/what-is-renewable-energy-d7e60a1a463a",
            ),
            SizedBox(height: 16),
            BlogPostCard(
              title: 'Composting at Home',
              description:
                  'Learn the basics of composting organic waste at home.',
              imageUrl: 'lib/images/tip5.png',
              bg: Color.fromARGB(255, 248, 219, 219),
              url:
                  "https://www.quora.com/What-is-the-best-way-to-get-started-with-composting?no_redirect=1",
            ),
            SizedBox(height: 16),
            BlogPostCard(
              title: 'Green Transportation Alternatives',
              description: 'Explore eco-friendly transportation methods.',
              imageUrl: 'lib/images/tip6.png',
              bg: Color.fromARGB(255, 243, 236, 219),
              url:
                  "https://earth.org/8-sustainable-transport-solutions-to-improve-urban-mobility-in-the-us/",
            ),
            SizedBox(
              height: 20,
            )
          ],
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
                child: Icon(Icons.lightbulb,
                    color: Color.fromARGB(255, 243, 86, 149))),
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

class BlogPostCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color bg;
  final String url;

  const BlogPostCard(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.bg,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showWebViewModal(context, url);
      },
      child: Container(
        height: 185,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          color: bg,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  imageUrl,
                  height: 90,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: "CenturyGothic",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          fontFamily: "CenturyGothic",
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
