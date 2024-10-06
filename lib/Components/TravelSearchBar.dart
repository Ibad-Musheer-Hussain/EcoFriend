import 'package:ecofriend/Components/card%20pager.dart';
import 'package:ecofriend/functions/showDialog.dart';
import 'package:ecofriend/functions/showProductDetails.dart';
import 'package:ecofriend/functions/showScanOptions.dart';
import 'package:ecofriend/functions/showWeb.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TravelSearchBar extends StatefulWidget {
  const TravelSearchBar({super.key});

  @override
  State<TravelSearchBar> createState() => _TravelSearchBarState();
}

class _TravelSearchBarState extends State<TravelSearchBar> {
  TextEditingController search = TextEditingController();
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'wgSQyza_iF4',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      enableCaption: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 130,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 243, 86, 149),
                  Color.fromARGB(255, 243, 86, 149)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Want to make the environment safe?',
                  style: TextStyle(
                    fontFamily: "CenturyGothic",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.search,
                          color: Color.fromARGB(255, 243, 86, 149)
                              .withOpacity(0.6)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: search,
                          decoration: InputDecoration(
                            hintText: 'Enter Barcode to verify',
                            hintStyle: TextStyle(
                              fontFamily: "CenturyGothic",
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          showScanOptions(context);
                          showProductDetails(context, search.text.toString());
                        },
                        icon: Icon(Icons.arrow_forward_outlined),
                        color:
                            Color.fromARGB(255, 243, 86, 149).withOpacity(0.6),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: HorizontalCardPager(
            cardTitles: [
              'Learn how to reduce plastic waste in everyday life.',
              'Adopt a more sustainable lifestyle with these tips.',
              'Explore how to make eco-conscious shopping decisions.',
              'Discover the benefits of switching to renewable energy.',
              'Learn the basics of composting organic waste at home.'
            ],
            color: [
              Color.fromARGB(255, 248, 219, 219),
              Color.fromARGB(255, 255, 255, 220),
              Color.fromARGB(255, 255, 222, 179),
              Color.fromARGB(255, 198, 218, 180),
              Color.fromARGB(255, 248, 219, 219),
            ],
            imageUrl: [
              'lib/images/tip1.png',
              'lib/images/tip2.png',
              'lib/images/tip3.png',
              'lib/images/tip4.png',
              'lib/images/tip5.png',
              'lib/images/tip6.png'
            ],
          ),
        ),
        const SizedBox(height: 30),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 2 - 25,
                child: Card(
                  color: Color.fromARGB(255, 248, 219, 219),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Safe \nEarth',
                          style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  '7 min',
                                  style: const TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 243, 86, 149),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showVideoDialog(context, _controller);
                                    },
                                    icon: Icon(Icons.play_arrow),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 2 - 25,
                child: Card(
                  color: Color(0xFFDDE255),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Eco-friendly \nVibes',
                          style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  '20 min',
                                  style: const TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 38, 68, 20),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showVideoDialog(context, _controller);
                                    },
                                    icon: Icon(Icons.play_arrow),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 2 - 25,
                child: Card(
                  color: Color.fromARGB(255, 252, 196, 123),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Guided\nmeditation',
                          style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  '45 min',
                                  style: const TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 249, 136, 5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showVideoDialog(context, _controller);
                                    },
                                    icon: Icon(Icons.play_arrow),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            color: Color.fromARGB(255, 248, 219, 219),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Learn More Here',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 33, 37, 41),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      ...[
                        {
                          'text': 'Open Food Facts',
                          'icon': Icons.search,
                          'link': "https://world.openfoodfacts.org/"
                        },
                        {
                          'text': 'FDA (USA)',
                          'icon': Icons.restaurant_menu,
                          'link': "https://www.fda.gov/"
                        },
                        {
                          'text': 'EPA (USA)',
                          'icon': Icons.recycling,
                          'link': "https://www.epa.gov/"
                        },
                      ].map((item) {
                        final String text = item['text'] as String;
                        final IconData icon = item['icon'] as IconData;
                        final String url = item['link'] as String;
                        return GestureDetector(
                          onTap: () {
                            showWebViewModal(context, url);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 243, 86, 149),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    icon,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Text(
                                  text,
                                  style: const TextStyle(
                                    fontFamily: "CenturyGothic",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 55, 71, 79),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
