// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';

Future<Map<String, dynamic>?> authenticate(
    FormBuilderState? formState, BuildContext context) async {
  final url = 'http://192.168.18.9:3000/api/authenticate';
  final headers = {
    'Content-Type': 'application/json',
  };

  final email = formState?.fields['email']?.value;
  final password = formState?.fields['pass']?.value;

  final body = jsonEncode({
    //'email': email,
    //'password': password,
    'email': "ibadmusheer20@gmail.com",
    'password': "Xgen123@",
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('Response data: $data');
      return data;
    } else {
      print('Failed to authenticate. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
