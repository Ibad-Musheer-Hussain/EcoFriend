import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updatepass(String id, String pass, String newpass) async {
  final url = 'http://192.168.18.9:3000/api/update-password/$id';

  final body = jsonEncode({'pass': pass, 'newpass': newpass});

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print("Response body: $responseBody");
    } else {
      print("Failed with status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}
