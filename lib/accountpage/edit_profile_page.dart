import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas/auth/auth_service.dart';

Color primaryColor = Color(0xFFFFA62F);

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  final _auth = AuthService();
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          fullNameController.text = userDoc['fullName'];
          emailController.text = userDoc['email'];
          phoneController.text = userDoc['phoneNumber'];
          usernameController.text = userDoc['username'];
          // For security reasons, you shouldn't fetch the password directly like this.
          // passwordController.text = userDoc['password'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/avatar.png'), // Replace with your image asset
            ),
            TextButton(
              onPressed: () {
                // Change picture action
              },
              child: Text('Change Picture'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Validation
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Email and Password must be filled')),
                  );
                  return;
                }

                try {
                  await _auth.updateUserProfile(
                    fullNameController.text,
                    emailController.text,
                    phoneController.text,
                    usernameController.text,
                    passwordController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                  Navigator.pop(context, true);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating profile: $e')),
                  );
                }
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
