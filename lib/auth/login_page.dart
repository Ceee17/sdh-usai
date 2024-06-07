import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas/startingpage/starting_page.dart';
import 'package:uas/auth/register_page.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // super.dispose(); // not needed in StatelessWidget
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background container with rounded corners
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.7, // Adjust height relative to screen size
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
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: Color(0xffffffff),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: Color(0xffffffff),
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
                                builder: (context) => Placeholder(), // Placeholder for ForgotPasswordPage
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.012),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => StartingPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFA62F),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: width * 0.25, vertical: height * 0.01),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        '-Or Login with-',
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: width * 0.1,
                          width: width * 0.1,
                          color: Colors.white,
                          child: TextButton(
                            onPressed: () {},
                            child: Image.asset(
                              'assets/google-icon.png',
                              width: width * 0.07,
                              height: width * 0.07,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Do not have an account?',
                            style: TextStyle(
                              color: Color(0xffffffff),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            height: height * 0.05,
                            width: width * 0.3,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      var offsetAnimation = animation.drive(tween);

                                      return FadeTransition(
                                        opacity: animation,
                                        child: SlideTransition(
                                          position: offsetAnimation,
                                          child: RegisterPage(), // Placeholder for SignupPage
                                        ),
                                      );
                                    },
                                    transitionDuration: Duration(milliseconds: 850),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Color(0xff8da2e2),
                                  fontSize: width * 0.03,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Foreground content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/loginpage.png',
                    width: width * 0.7,
                    height: width * 0.32,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Login to your ..',
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
          ],
        ),
      ),
    );
  }

  void displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
