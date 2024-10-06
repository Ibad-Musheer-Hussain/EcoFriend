import 'package:ecofriend/functions/fetchProductData.dart';
import 'package:ecofriend/functions/showEcoscore.dart';
import 'package:ecofriend/functions/showNutriscore.dart';
import 'package:ecofriend/functions/showpackagingdialog.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatelessWidget {
  final Map<String, dynamic> product;
  final String categoriesText;
  final String ingredientsText;
  final List<String> targetIngredients;
  final ScrollController scrollController;

  const ProductDetailView({
    Key? key,
    required this.product,
    required this.categoriesText,
    required this.ingredientsText,
    required this.targetIngredients,
    required this.scrollController,
  }) : super(key: key);

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                if (product['image_url'] != null)
                  Center(
                    child: Image.network(product['image_url'],
                        height: 300, width: 300),
                  ),
                const SizedBox(height: 16),
                Text(
                  product['product_name'] != ''
                      ? '${product['product_name']} ${product['quantity'] ?? ''}'
                      : 'No name',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text("Brand:",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(product['brands'] ?? 'No brand',
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 16),
                const Text("Category:",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(categoriesText,
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 16),
                const Text("Ingredients:",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text.rich(
                  style: const TextStyle(fontSize: 20),
                  TextSpan(
                    children: ingredientsText.split(', ').map<InlineSpan>((ingredient) {
                      ingredient = ingredient.trim().toUpperCase();
                      bool isCommon = targetIngredients.any(
                          (target) => ingredient.contains(target));
                      bool isLast = ingredientsText.split(', ').last.trim().toUpperCase() == ingredient;
                      String separator = isLast ? '.' : ', ';
                      return TextSpan(
                        children: [
                          TextSpan(
                            text: capitalizeFirstLetter(ingredient.toLowerCase()),
                            style: TextStyle(
                                fontSize: 20,
                                color: isCommon ? Colors.red : Colors.black),
                          ),
                          TextSpan(
                              text: separator,
                              style: const TextStyle(fontSize: 20, color: Colors.black)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Packaging:",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        '${getPackagingTextList(product).join(",\n ")}',
                        style: const TextStyle(fontSize: 20),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showPackagingDialog(context, getPackagingTextList(product));
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Ecoscore:",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['ecoscore_data']?['grade']?.toUpperCase() ?? 'Not Available',
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        try {
                          showecosore(context, product['ecoscore_data']?['grade'].toUpperCase());
                        } catch (e) {
                          Noecosore(context);
                        }
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Nutritional Information:",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                if (product['nutriments'] != null) ...[
                  Text(
                      'Energy: ${product['nutriments']['energy-kcal_100g']} kcal per 100g',
                      style: const TextStyle(fontSize: 20)),
                  Text(
                      'Fat: ${product['nutriments']['fat_100g']} g per 100g',
                      style: const TextStyle(fontSize: 20)),
                  Text(
                      'Carbohydrates: ${product['nutriments']['carbohydrates_100g']} g per 100g',
                      style: const TextStyle(fontSize: 20)),
                  Text(
                      'Proteins: ${product['nutriments']['proteins_100g']} g per 100g',
                      style: const TextStyle(fontSize: 20)),
                ],
                const SizedBox(height: 16),
                const Text("Nutriscore Grade:",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        product['nutriscore_grade']?.toUpperCase() ?? 'No Nutriscore',
                        style: const TextStyle(fontSize: 20)),
                    IconButton(
                      onPressed: () {
                        try {
                          shownutriscore(context, product['nutriscore_grade'].toUpperCase());
                        } catch (e) {
                          Nonutrisore(context);
                        }
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
