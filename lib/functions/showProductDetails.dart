import 'package:ecofriend/Components/ProductDetailView.dart';
import 'package:ecofriend/Components/ProductServerView.dart';
import 'package:ecofriend/functions/fetchProductData.dart';
import 'package:ecofriend/functions/fetchfromServer.dart';
import 'package:ecofriend/item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Future<void> showProductDetails(BuildContext context, String barcode) async {
  var box = await Hive.openBox('history');

  List<dynamic> putInBox = box.get('history', defaultValue: []) ?? [];

  final List<String> targetIngredients = [
    "SUGAR",
    "SALT",
    "CORN SYRUP",
    "HIGH-FRUCTOSE CORN SYRUP",
    "HCFS",
    "PALM",
    "VEGETABLE OIL",
    "ASPARTAME",
    "MSG",
    "PHOSPHATE",
    "NITRATE",
    "NITRITE",
    "BUTANE",
    "PROPANE",
    "METHANE",
    "ARSENIC",
    "PALM OIL"
  ];

  showModalBottomSheet(
    backgroundColor: Color.fromARGB(255, 243, 86, 149),
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext context) {
      Future<Map<String, dynamic>> future1 = fetchProductData(barcode);
      Future<Map<String, dynamic>> future2 = fetchfromServer(barcode);

      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 86, 149),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: future1,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!['product'] == null) {
              return FutureBuilder<Map<String, dynamic>>(
                future: future2,
                builder: (context, future2Snapshot) {
                  if (future2Snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  } else if (future2Snapshot.hasError ||
                      !future2Snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: Product not found in database. No backup data available.',
                        ),
                      ),
                    );
                  }
                  final product = future2Snapshot.data!;
                  print(product);
                  return DraggableScrollableSheet(
                    expand: false,
                    snapAnimationDuration: const Duration(milliseconds: 500),
                    snap: true,
                    snapSizes: const [1.0],
                    initialChildSize: 0.6,
                    minChildSize: 0.3,
                    maxChildSize: 1.0,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return ProductServerView(
                        product: product,
                        targetIngredients: targetIngredients,
                        scrollController: scrollController,
                      );
                    },
                  );
                },
              );
            }

            final product = snapshot.data!['product'];
            String categoriesText = product['categories'] ?? 'No category';
            String ingredientsText =
                product['ingredients_text_en']?.replaceAll('_', '') ??
                    'No ingredients';

            Item newItem = Item(
              product['product_name'] ?? '',
              product['brands'] ?? '',
              categoriesText,
              product['ecoscore_data']?['grade']?.toUpperCase() ??
                  'Not Available',
              getPackagingTextList(product),
              product['image_url'] ?? '',
              ingredientsText,
              product['nutriments'] ?? {},
              product['nutriscore_grade']?.toUpperCase(),
              barcode,
            );

            bool itemExists = putInBox.any((item) => item.name == newItem.name);
            if (!itemExists) {
              putInBox.add(newItem);
            }

            return DraggableScrollableSheet(
              expand: false,
              snapAnimationDuration: const Duration(milliseconds: 500),
              snap: true,
              snapSizes: const [1.0],
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 1.0,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ProductDetailView(
                  product: product,
                  categoriesText: categoriesText,
                  ingredientsText: ingredientsText,
                  targetIngredients: targetIngredients,
                  scrollController: scrollController,
                );
              },
            );
          },
        ),
      );
    },
  ).whenComplete(() async {
    Navigator.pop(context);
    await box.put('history', putInBox);
  });
}
