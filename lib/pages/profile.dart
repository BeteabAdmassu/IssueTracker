// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authService.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    final UserCredential = AuthService().signInWithGoogle();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              onPressed: () {
                AuthService().signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Profile'),
              ElevatedButton(
                onPressed: () {
                  print(FirebaseAuth.instance.currentUser!.email);
                },
                child: const Text('Get Email'),
              ),
              Text(UserCredential.user!.displayName!),
              Text(UserCredential.user!.email!),
              // Image.network(UserCredential.user!.photoURL!),
              Text(UserCredential.user!.phoneNumber!),
              Text(UserCredential.user!.uid!),
            ],
          ),
        ),
      ),
    );
  }
}
