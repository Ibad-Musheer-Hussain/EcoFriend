import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ecofriend/Objects/JSONData.dart';
import 'package:ecofriend/Profile_new.dart';
import 'package:flutter/material.dart';

Future<void> updateUser(
    String id,
    String email,
    String name,
    int age,
    String location,
    String language,
    String gender,
    BuildContext context) async {
  late JsonStorage _jsonStorage;

  final url = 'http://192.168.18.9:3000/api/update-user-and-post/$id';

  final body = jsonEncode({
    'email': email,
    'name': name,
    'age': age,
    'location': location,
    'role': "User",
    'language': language,
    'gender': gender,
  });

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

      print("Response Body: $responseBody");

      if (responseBody.containsKey('user') && responseBody['user'] != null) {
        var box = Hive.box('UserInfo');
        _jsonStorage = JsonStorage(box);

        await _jsonStorage.clearData(); 
        await _jsonStorage
            .storeJsonData(responseBody['user']);

        final Map<dynamic, dynamic>? _UserProfile = _jsonStorage.getJsonData();
        if (_UserProfile != null && _UserProfile.isNotEmpty) {
          email = _UserProfile['email'] ?? "Unknown";
          name = _UserProfile['name'] ?? "Unknown";
          age = _UserProfile['age'] ?? 0;
          location = _UserProfile['location'] ?? "Unknown";
          language = _UserProfile['language'] ?? "Unknown";
          gender = _UserProfile['gender'] ?? "Unknown";
        } else {
          print("No valid user data found in Hive.");
        }
      } else {
        print(
            "Response does not contain updated user data: ${responseBody['user']}");
      }
    } else {
      print('Failed to update user: ${response.statusCode}, ${response.body}');
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyProfileScreen2()));
  } catch (e) {
    print('Error occurred while updating user: $e');
  }
}
