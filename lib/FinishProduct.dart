import 'package:ecofriend/Featured.dart';
import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Learn.dart';
import 'package:ecofriend/Profile_new.dart';
import 'package:flutter/material.dart';

class FinishProduct extends StatefulWidget {
  const FinishProduct(
      {super.key,
      required this.uploadImagesFuture,
      required this.Name,
      required this.ingredients,
      required this.barcode});
  final Future<String> uploadImagesFuture;
  final String Name;
  final String ingredients;
  final String barcode;
  @override
  State<FinishProduct> createState() => _FinishProductState();
}

class _FinishProductState extends State<FinishProduct> {
  int _selectedIndex = 0;
  TextEditingController Name = TextEditingController();
  TextEditingController Brand = TextEditingController();
  TextEditingController Category = TextEditingController();
  TextEditingController Packaging = TextEditingController();
  TextEditingController Ingredients = TextEditingController();
  TextEditingController Energy = TextEditingController();
  TextEditingController Fat = TextEditingController();
  TextEditingController Carb = TextEditingController();
  TextEditingController Protein = TextEditingController();

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

  void initState() {
    super.initState();
    Name.text = widget.Name;
    Ingredients.text = widget.ingredients;
    print(widget.ingredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Text("Almost Finished",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFFDDE255),
            ),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
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
                        controller: Name,
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Brand",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        controller: Brand,
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
                          hintText: 'Enter product brand',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Category",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        controller: Category,
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
                          hintText: 'Enter product category',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Packaging",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        controller: Packaging,
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
                          hintText: 'Enter product packaging',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Ingredients",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        minLines: 1,
                        maxLines: 8,
                        controller: Ingredients,
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
                          hintText: 'Enter product ingredients',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Calories",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        controller: Energy,
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
                          hintText: 'Enter product enery kcal/100g',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Fats",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        controller: Fat,
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
                          hintText: 'Enter product Fat/100g',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Carbohydrates",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        controller: Carb,
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
                          hintText: 'Enter product Carbs/100g',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, top: 32, right: 32, bottom: 10),
                        child: Text(
                          "Product Protein",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: TextField(
                        controller: Protein,
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
                          hintText: 'Enter product protein/100g',
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FloatingActionButton.extended(
                        backgroundColor: Color.fromARGB(255, 38, 68, 20),
                        onPressed: () {},
                        label: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text("Submit",
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
