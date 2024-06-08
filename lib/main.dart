import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas/startingpage/starting_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'JungleFeast',
        theme: ThemeData(
            // primarySwatch: Colors.blue,
            ),
        debugShowCheckedModeBanner: false,
        home: const StartingPage());
  }
}
