import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Login.dart';
import 'package:ecofriend/Objects/JSONData.dart';
import 'package:ecofriend/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  late bool isLoggedIn;
  await Hive.initFlutter();
  await Hive.openBox('UserInfo');
  final box = Hive.box('UserInfo');
  Hive.registerAdapter(ItemAdapter());
  JsonStorage _jsonStorage = JsonStorage(box);
  try {
    Map<dynamic, dynamic> storedData =
        Map<dynamic, dynamic>.from(_jsonStorage.getJsonData());
    isLoggedIn = true;
  } catch (e) {
    isLoggedIn = false;
  }

  await Future.delayed(Duration(seconds: 2));
  FlutterNativeSplash.remove();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecosia',
      theme: ThemeData(
        fontFamily: 'CenturyGothic',
        textTheme: TextTheme(
            bodyLarge: TextStyle(fontFamily: 'CenturyGothic'),
            bodyMedium: TextStyle(fontFamily: 'CenturyGothic'),
            bodySmall: TextStyle(fontFamily: 'CenturyGothic')),
      ),
      home: isLoggedIn ? HomeScreen() : Login(),
    );
  }
}
