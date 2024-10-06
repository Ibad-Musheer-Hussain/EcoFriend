import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<Map<String, dynamic>> fetchfromServer(String barcode) async {
  final response = await http.get(Uri.parse(
      "http://192.168.100.19:3000/api/get-product-by-barcode?barcode=$barcode"));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    await Future.delayed(Duration(seconds: 6));
    throw Exception('Failed to load product data');
  }
}
