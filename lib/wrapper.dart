import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas/homepage/home_page.dart';
import 'package:uas/auth/login_page.dart';
import 'package:uas/startingpage/starting_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"),
          );
        } else {
          if (snapshot.data == null) {
            return const LoginPage();
          } else {
            print('routing to homepage...');
            return const HomePage(); // nanti ganti jadi homepage
          }
        }
      },
    ));
  }
}
