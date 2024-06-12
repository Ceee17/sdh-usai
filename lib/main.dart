import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/aboutus/about_us_page.dart';
import 'package:uas/auth/login_page.dart';
import 'package:uas/startingpage/starting_page.dart';
import 'package:uas/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JungleFeast',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          ),
      debugShowCheckedModeBanner: false,
      home: isFirstLaunch ? StartingPage() : Wrapper(),
    );
  }
}
