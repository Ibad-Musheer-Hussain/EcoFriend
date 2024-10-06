import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchProductData(String barcode) async {
  final response = await http.get(
      Uri.parse('https://world.openfoodfacts.org/api/v2/product/$barcode'));

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load product data');
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

List<String> getPackagingTextList(Map<String, dynamic> product) {
  List<String> packagingTextList = [];

  if (product['packaging_text_en'] != null &&
      product['packaging_text_en'].toString().trim().isNotEmpty) {
    packagingTextList.add(
        capitalizeFirstLetter(product['packaging_text_en'].toString().trim()));
  }

  if (product['packaging_materials_tags'] is List) {
    List<dynamic> packagingMaterialsTags = product['packaging_materials_tags'];

    for (var tag in packagingMaterialsTags) {
      String cleanTag = tag.toString().trim().replaceAll('en:', '');
      if (cleanTag.isNotEmpty) {
        packagingTextList.add(capitalizeFirstLetter(cleanTag));
      }
    }
  }

  String cleanPrefix(String value) {
    if (value.contains(':')) {
      return value.split(':')[1];
    }
    return value;
  }

  if (packagingTextList.isEmpty) {
    (product['packagings'] as List<dynamic>).forEach((item) {
      final material = cleanPrefix(item['material']);
      packagingTextList.add(capitalizeFirstLetter(material));
    });
  }

  if (packagingTextList.isEmpty) {
    packagingTextList.add('No Packaging information available');
  }

  return packagingTextList;
}
