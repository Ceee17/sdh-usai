import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas/accountpage/account_page.dart';
import 'package:uas/auth/auth_service.dart';
import 'package:uas/auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _phonenumberController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Color(0xffd9d9d9),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Background text
            Container(
              padding: EdgeInsets.all(0.0),
              child: Center(
                child: Align(
                  alignment: Alignment(-0.85, -0.38),
                  child: Text(
                    'Create your Flashccount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Foreground content
            Positioned(
              top: height * 0.05,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Centered Image
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/registerpage.png',
                      width: width * 0.6,
                      height: height * 0.2,
                    ),
                  ),
                  // Left-aligned Text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Text(
                        'Create your ...',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Form container
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.7, // Adjust height relative to screen size
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
                      TextField(
                        controller: _fullnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          labelText: 'Full Name',
                        ),
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
                          labelText: 'E-mail',
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextField(
                        controller: _phonenumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          labelText: 'Phone Number',
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          labelText: 'Username',
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
                          fillColor: Color(0xffffffff),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      ElevatedButton(
                        onPressed: _signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFA62F),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.28,
                              vertical: height * 0.012),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.black,
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
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      const begin = Offset(0.0, -1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return FadeTransition(
                                        opacity: animation,
                                        child: SlideTransition(
                                          position: offsetAnimation,
                                          child: LoginPage(),
                                        ),
                                      );
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 850),
                                  ),
                                );
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  color: Color(0xff8da2e2),
                                  fontSize: width * 0.035,
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
          ],
        ),
      ),
    );
  }

  void displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountPage()),
      );

  _signup() async {
    await _auth.createUserWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    Navigator.pop(context);
    // if (user != null) {
    //   // log("User Created Succesfully");
    //   goToHome(context);
    // }
  }
}
