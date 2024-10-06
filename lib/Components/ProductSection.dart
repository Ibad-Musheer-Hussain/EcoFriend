import 'package:flutter/material.dart';

class ProductSection extends StatelessWidget {
  final Color backgroundColor;
  final String productName;
  final String description;
  final String imageUrl;
  final Color bgLeft;
  final double height;

  const ProductSection(
      {required this.backgroundColor,
      required this.productName,
      required this.description,
      required this.imageUrl,
      required this.bgLeft,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: backgroundColor, // Background color for each product section

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: bgLeft,
            width: MediaQuery.of(context).size.width / 2,
            child: Image.asset(
              imageUrl,
              height: 247,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          // Space between image and text
          Container(
            padding: EdgeInsets.all(20), // Add padding for better spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontFamily:
                        "CenturyGothic", // Font to match the minimalist style
                    fontSize: 24, // Adjusted font size for consistency
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Keep the text color bold
                    letterSpacing: 0.5, // Add slight spacing between letters
                  ),
                ),
                SizedBox(height: 8), // Reduced spacing for a more compact look
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  child: Text(
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis,
                    description,
                    style: TextStyle(
                      fontFamily: "CenturyGothic",
                      fontSize: 11,
                      color: Colors.black.withOpacity(0.8), //
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
