import 'package:flutter/material.dart';
import 'package:uas/startingpage/starting_page.dart';

void main() {
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
