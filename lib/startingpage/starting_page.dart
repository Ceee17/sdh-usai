import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  Future<void> _completeInitialSetup(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Wrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: white),
        child: Column(
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  '“The only trip you will regret\nis the one You didn’t take”',
                  textDirection: TextDirection.ltr,
                  style: startingText(22, FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            h(20),
            Image.asset(
              'assets/startingpage.png',
              height: 120,
              fit: BoxFit.contain,
            ),
            h(20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Center(
                child: Text(
                  "Are you ready to have fun with us? Let’s trust us and\n"
                  "share your dream holiday with us!\n"
                  "Welcome to Junglefeast",
                  textDirection: TextDirection.ltr,
                  style: startingText(13, FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            h(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Divider(color: black),
            ),
            h(10),
            Text('SD-H USAI', style: startingText(18, FontWeight.w900)),
            h(5),
            Column(
              children: [
                Text('Jafier Andreas 535220013',
                    style: startingText(13, FontWeight.normal)),
                Text('Nelson 535220021',
                    style: startingText(13, FontWeight.normal)),
                Text('Jessen Chayadi 535220023',
                    style: startingText(13, FontWeight.normal)),
                Text('Finnia Li 535220030',
                    style: startingText(13, FontWeight.normal)),
                Text('Timoty Wahyudi P 535220043',
                    style: startingText(13, FontWeight.normal)),
              ],
            ),
            h(40),
            ElevatedButton(
              onPressed: () => _completeInitialSetup(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Get Started!',
                style: customText(22, FontWeight.w600, white),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Copyright © 2024 SD-H USAI',
                style: copyrightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
