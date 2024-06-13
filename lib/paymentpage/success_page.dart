import 'package:flutter/material.dart';

void main() {
  runApp(SuccessPage());
}

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPage();
}

class _SuccessPage extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Success',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: PaymentSuccessPage(),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(), // Empty container to simulate no leading icon
      ),
      body: Column(
        children: <Widget>[
          Spacer(),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/success.png',
                    width: 175.0,
                    height: 175.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Payment Success!!!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to the home page or perform another action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 130.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded corners
                      ),
                      textStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    child: Text('Back Home'),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Copyright © 2024 SD-H USAI',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
