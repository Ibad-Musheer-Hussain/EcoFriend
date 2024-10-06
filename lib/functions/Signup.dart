import 'dart:convert';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

Future<void> Signup(String name, String email, String password, String gender,
    FormBuilderState? formState) async {
  final url = 'http://192.168.18.9:3000/api/register-user-and-post';
  final headers = {
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'email': email,
    'password': password,
    'name': name,
    'age': int.tryParse(formState?.fields['age']?.value ?? ''),
    'location': formState?.fields['location']?.value,
    'role': "User",
    'language': formState?.fields['language']?.value,
    'gender': gender
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('Response data: $data');
    } else {
      print('Failed to authenticate. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
