import 'package:flutter/material.dart';

void showecosore(BuildContext context, String ecoscore) {
  String additionalText = "";
  Map<String, String> additionalTextMap = {
    'a':
        "This product is highly recommended due to its exceptional environmental benefits and minimal impact. It's the most eco-friendly choice available.",
    'b':
        "This product is recommended as its environmental impact is minimal. It is a solid choice for sustainability with negligible ecological harm.",
    'c':
        "This product is acceptable but not the best option. While it doesn't pose a direct threat to the environment, better alternatives exist that offer a lower ecological footprint.",
    'd':
        "This product is not recommended. Its environmental impact is concerning, and more sustainable options should be prioritized to reduce harm.",
    'e':
        "This product is strongly discouraged due to its significant negative impact on the environment. Avoid usage where possible in favor of eco-friendly alternatives."
  };

  showDialog(
    context: context,
    builder: (BuildContext context) {
      additionalTextMap.forEach((key, value) {
        if (ecoscore.toLowerCase().contains(key.toLowerCase())) {
          additionalText = value;
        }
      });
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Eco Score Rating",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )),
        content: ecoscore.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Text(
                          ecoscore,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Text(
                    additionalText,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              )
            : Text(
                'No Eco Score Rating available due to low access to information',
                style: TextStyle(fontSize: 16)),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void Noecosore(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Eco Score Rating",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )),
        content: Text(
          'Eco score is not available for all types of products.',
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
