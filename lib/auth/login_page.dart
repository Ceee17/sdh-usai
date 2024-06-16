import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas/auth/auth_service.dart';
import 'package:uas/auth/forgot_password_page.dart';
import 'package:uas/design/design.dart';
import 'package:uas/routes.dart';
import 'package:uas/wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  bool isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.1, vertical: height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/loginpage.png',
                      width: width * 0.7,
                      height: width * 0.42,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Login to your JungleFeast Account',
                        style: TextStyle(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: height * 0.7,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(37.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.05),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: white,
                          labelText: 'E-mail',
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: white,
                          labelText: 'Password',
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: black,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.012),
                      SizedBox(
                        width: width * 1,
                        height: height * 0.06,
                        child: ElevatedButton(
                          onPressed: () => _login(),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: white,
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.01),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        '-Or Login with-',
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      isLoading
                          ? const CircularProgressIndicator()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: width * 0.1,
                                width: width * 0.1,
                                color: Color(0xffD9D9D9),
                                child: TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    UserCredential? userCredential =
                                        await _auth.loginWithGoogle();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (userCredential != null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Wrapper(),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Google Sign-In failed.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/google-icon.png',
                                    width: width * 0.07,
                                    height: width * 0.07,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: height * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Do not have an account?',
                            style: TextStyle(
                              color: black,
                            ),
                          ),
                          SizedBox(height: height * 0.001),
                          Container(
                            height: height * 0.05,
                            width: width * 0.3,
                            child: TextButton(
                              onPressed: () {
                                navigateToSignup(context);
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Color(0xff8da2e2),
                                  fontSize: width * 0.040,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.05),
                      Text('Copyright © 2024 SD-H USAI', style: copyrightText),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = await _auth.loginUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Wrapper()),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Login failed. Please check your credentials.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
