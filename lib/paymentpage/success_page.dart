import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: Container(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/success.gif',
                  width: 175.0,
                  height: 175.0,
                ),
                h(20.0),
                Text('Payment Success!!!', style: headerText(24)),
                h(40.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 130.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('Copyright © 2024 SD-H USAI', style: copyrightText),
          ),
        ],
      ),
    );
  }
}
