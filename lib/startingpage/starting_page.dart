import 'package:flutter/material.dart';
import 'package:uas/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/auth/login_page.dart';

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
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Center(
                child: Text(
                  '“The only trip you will regret\nis the one You didn’t take”',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Poppins",
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/startingpage.png',
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: const Center(
                child: Text(
                  "Are you ready to have fun with us? Let’s trust us and\n"
                  "share your dream holiday with us!\n"
                  "Welcome to Junglefeast",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Poppins",
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const Divider(color: Colors.black87),
            ),
            const SizedBox(height: 10),
            const Text(
              'SD-H USAI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: "Poppins",
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: const [
                Text('Jafier Andreas 535220013',
                    style: TextStyle(fontSize: 13, fontFamily: "Poppins")),
                Text('Nelson 535220021',
                    style: TextStyle(fontSize: 13, fontFamily: "Poppins")),
                Text('Jessen Chayadi 535220023',
                    style: TextStyle(fontSize: 13, fontFamily: "Poppins")),
                Text('Finnia Li 535220030',
                    style: TextStyle(fontSize: 13, fontFamily: "Poppins")),
                Text('Timoty Wahyudi P 535220043',
                    style: TextStyle(fontSize: 13, fontFamily: "Poppins")),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _completeInitialSetup(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA62F),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text('Get Started!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Copyright © 2024 SD-H USAI',
                style: TextStyle(
                    fontSize: 12, color: Colors.grey, fontFamily: "Poppins"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StartingPage(),
  ));
}
