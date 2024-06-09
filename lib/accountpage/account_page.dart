import 'package:uas/accountpage/edit_profile_page.dart';
import 'package:uas/auth/auth_service.dart';
import 'package:uas/auth/login_page.dart';
import 'package:uas/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/avatar.png'), // Replace with your image asset
            ),
            SizedBox(height: 10),
            Text(
              'Nelson Carloss',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Card(
              elevation: 6.0,
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Edit Profile'),
                    onTap: () {
                      _navigateToEditProfilePage(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Payments'),
                    onTap: () {
                      // Navigate to Payments screen
                    },
                    enabled: false,
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Customer Services(?)'),
                    onTap: () {
                      // Navigate to Customer Services screen
                    },
                    enabled: false,
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Settings'),
                    onTap: () {
                      // Navigate to Settings screen
                    },
                    enabled: false,
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.orange),
                    ),
                    onTap: () async {
                      await auth.signout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToEditProfilePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditProfilePage()),
  );
}


// class AccountPage extends StatelessWidget {
//   const AccountPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final auth = AuthService();
//     return Scaffold(
//       body: Align(
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Welcome User",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
//             ),
//             const SizedBox(height: 20),
//             CustomButton(
//               label: "Sign Out",
              // onPressed: () async {
              //   await auth.signout();
              //   // goToLogin(context); //boleh dihapus
              // },
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // boleh dihapus
//   // goToLogin(BuildContext context) => Navigator.push(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => const LoginPage()),
//   //     );
// }
