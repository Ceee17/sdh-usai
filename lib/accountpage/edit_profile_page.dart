import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFFFA62F);

class EditProfilePage extends StatelessWidget {
  final TextEditingController fullNameController =
      TextEditingController(text: 'Nelson Carloss');
  final TextEditingController emailController =
      TextEditingController(text: 'examplemail@example.com');
  final TextEditingController phoneController =
      TextEditingController(text: '081234567890');
  final TextEditingController usernameController =
      TextEditingController(text: 'Ne1L');
  final TextEditingController passwordController =
      TextEditingController(text: '12345678');

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
              onPressed: () {
                // Update profile action
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
