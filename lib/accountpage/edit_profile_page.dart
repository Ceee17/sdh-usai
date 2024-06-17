import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uas/auth/auth_service.dart';
import 'dart:io';
import 'package:uas/design/design.dart';

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

  final _formKey = GlobalKey<FormState>();
  User? currentUser = FirebaseAuth.instance.currentUser;
  final _auth = AuthService();
  File? _image;
  String? _uploadedImageUrl;
  String? _selectedAvatarPath;
  bool isLoading = false;

  final List<String> avatarNames = [
    'bear',
    'bee',
    'cockatoo',
    'crab',
    'deer',
    'duck',
    'elephant',
    'fox',
    'harpseal',
    'lion',
    'monkey',
    'octopus',
    'owl',
    'panda',
    'penguin',
    'redpanda',
    'starfish',
    'toucan',
  ];

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
          _uploadedImageUrl = userDoc['imageUrl'];
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        isLoading = true;
      });

      await _uploadImage();

      setState(() {
        isLoading = false;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null && currentUser != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child(currentUser!.uid + '.jpg');
        await ref.putFile(_image!);
        final imageUrl = await ref.getDownloadURL();
        setState(() {
          _uploadedImageUrl = imageUrl;
          _selectedAvatarPath = null;
        });
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }

  void _chooseAvatar() async {
    print('isi dari avatarNames $avatarNames');
    String? selectedAvatar;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Avatar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Click the image then press OK to apply.'),
              h(20),
              Wrap(
                spacing: 10,
                children: avatarNames.map((avatar) {
                  String avatarPath = 'assets/avatar/$avatar.png';
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatar = avatarPath;
                      });
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(avatarPath),
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: selectedAvatar == avatarPath
                          ? Icon(Icons.check, color: blue)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showOptionDialog();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedAvatarPath = selectedAvatar;
                  _uploadedImageUrl = null;
                });
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showOptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Choose Avatar'),
                onTap: () {
                  Navigator.pop(context);
                  _chooseAvatar();
                },
              ),
              ListTile(
                title: Text('Upload'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedAvatarPath != null
                        ? AssetImage(_selectedAvatarPath!)
                        : (_uploadedImageUrl != null
                                ? NetworkImage(_uploadedImageUrl!)
                                : AssetImage('assets/avatar.png'))
                            as ImageProvider<Object>?,
                  ),
                  TextButton(
                    onPressed: isLoading ? null : _showOptionDialog,
                    child: Text('Change Picture'),
                  ),
                  h(20),
                  TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  h(20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
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
                  h(20),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  h(20),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  h(20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  h(20),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              await _uploadImage();

                              try {
                                await _auth.updateUserProfile(
                                  fullNameController.text,
                                  emailController.text,
                                  phoneController.text,
                                  usernameController.text,
                                  passwordController.text,
                                  imageUrl:
                                      _uploadedImageUrl ?? _selectedAvatarPath,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Profile updated successfully')),
                                );
                                Navigator.pop(context, true);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Error updating profile: $e')),
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                    child: Text(
                      'Update',
                      style: primaryBtnText,
                    ),
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
          ),
          if (isLoading)
            Container(
              color: black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
