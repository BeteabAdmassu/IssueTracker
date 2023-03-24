// ignore_for_file: prefer_const_constructors, pref_imageFileer_interpolation_to_compose_strings, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authService.dart';

class addIssue extends StatefulWidget {
  const addIssue({Key? key}) : super(key: key);

  @override
  State<addIssue> createState() => _addIssueState();
}

void showOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to profile screen
              Navigator.pushNamed(context, '/profile');
              // runApp(ProfilePage());
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Perform logout action
              AuthService().signOut();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

class _addIssueState extends State<addIssue> {
  late String _selectedCategory = 'Pothole';
  final List<String> _categories = [
    'Pothole',
    'Damaged side walk',
    'Broken street light',
    'Damaged road',
    'Damaged traffic light',
    'Damaged traffic sign',
    'Damaged traffic signal',
  ];

  File? get imageFile => _imageFile;
  File? _imageFile;

  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          // await _imagePicker.getImage(source: ImageSource.gallery,);
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error while picking the image: $e');
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 125, 139, 1),
          title: Text('Add Issue'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                showOptions(context);
              },
              child: Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  // backgroundImage: AssetImage('asset/sidePortriat.jpg'),
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Issue Type',
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.image,
                            size: 100,
                          ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Submit'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.location_on),
                  label: Text('Set Pointer on Map'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueGrey,
          elevation: 8.0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                iconSize: 40.0,
                icon: Icon(
                  Icons.near_me,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              SizedBox(width: 32.0),
              SizedBox(width: 32.0),
              IconButton(
                iconSize: 40.0,
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/NotificationPage');
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/addIssue');
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
