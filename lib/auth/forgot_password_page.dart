import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas/auth/auth_service.dart';
import 'package:uas/auth/login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _auth = AuthService();

  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Color(0xffd9d9d9),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Background text
            // Foreground container
            Positioned(
              top: height * 0.0175,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Align(
                    child: Image.asset(
                      'assets/forgotpasspage.png',
                      width: width * 0.7,
                      height: width * 0.5,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: width * 0.1, top: height * 0.01),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Form container
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.65, // Adjust height relative to screen size
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(37.0),
                    topRight: Radius.circular(0.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 30, left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.05),
                      Text(
                        'Enter Email Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height * 0.02),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          labelText: 'example@gmail.com',
                        ),
                      ),
                      SizedBox(height: height * 0.035),
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Back to sign in",
                            style: TextStyle(
                              color: Color(0xffABABAB),
                            ),
                          )),
                      SizedBox(height: height * 0.05),
                      ElevatedButton(
                        onPressed: () async {
                          await _auth
                              .sendPasswordResetLink(_emailController.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "An email for password reset has been send to your email!")));
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFA62F),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.25,
                              vertical: height * 0.01),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
