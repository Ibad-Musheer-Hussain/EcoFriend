import 'package:ecofriend/Better.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Future<void> Logout(BuildContext context) async {
  final box = await Hive.openBox('UserInfo');
  await box.clear();
  print('The UserInfo has been cleared.');
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Better()),
    (Route<dynamic> route) => false,
  );
}
