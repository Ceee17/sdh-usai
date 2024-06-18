import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final List<String> _avatarUrls = [
    'assets/avatar/bear.png',
    'assets/avatar/bee.png',
    'assets/avatar/cockatoo.png',
    'assets/avatar/crab.png',
    'assets/avatar/deer.png',
    'assets/avatar/duck.png',
    'assets/avatar/elephant.png',
    'assets/avatar/fox.png',
    'assets/avatar/harpseal.png',
    'assets/avatar/lion.png',
    'assets/avatar/monkey.png',
    'assets/avatar/octopus.png',
    'assets/avatar/owl.png',
    'assets/avatar/panda.png',
    'assets/avatar/penguin.png',
    'assets/avatar/redpanda.png',
    'assets/avatar/starfish.png',
    'assets/avatar/toucan.png',
  ];

  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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
            Positioned(
              top: height * 0.05,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/registerpage.png',
                      width: width * 0.6,
                      height: height * 0.2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Text(
                        'Create your JungleFeast Account',
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
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.7,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(37.0),
                    topRight: Radius.circular(0.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 30, left: 40, right: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.05),
                          TextFormField(
                            controller: _fullnameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              labelText: 'Full Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              labelText: 'E-mail',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _phonenumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              labelText: 'Phone Number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (!RegExp(r'^\+?[0-9]{10,13}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              labelText: 'Username',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              labelText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
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

                                          var tween = Tween(
                                                  begin: begin, end: end)
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
                                      fontSize: width * 0.040,
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
    if (_formKey.currentState!.validate()) {
      final String fullName = _fullnameController.text;
      final String email = _emailController.text;
      final String phoneNumber = _phonenumberController.text;
      final String username = _usernameController.text;
      final String password = _passwordController.text;

      try {
        User? user =
            await _auth.createUserWithEmailAndPassword(email, password);

        if (user != null) {
          // Pilih URL avatar secara random
          final String avatarUrl = (_avatarUrls..shuffle()).first;

          // Save additional user data in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'fullName': fullName,
            'email': email,
            'phoneNumber': phoneNumber,
            'username': username,
            'avatarUrl': avatarUrl,
            'creationTime': user.metadata.creationTime?.toIso8601String(),
            'lastSignInTime': user.metadata.lastSignInTime?.toIso8601String(),
          });
          Navigator.pop(context);
        }
      } catch (e) {
        print('Error: $e');
        displayToastMessage("Error: $e", context);
      }
    }
  }
}
