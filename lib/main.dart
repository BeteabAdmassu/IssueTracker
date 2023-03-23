// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:issuetracker/pages/home.dart';
import 'package:issuetracker/pages/login.dart';
import 'package:issuetracker/pages/loading.dart';
import 'package:issuetracker/pages/addIssue.dart';

void main() {
  runApp(MaterialApp(
    // giving default appearance till i implement the loading page
    initialRoute: '/login',
    routes: {
      '/': (context) => Loading(),
      '/login': (context) => Login(),
      '/home': (context) => Home(),
      '/addIssue': (context) => addIssue(),
    },
  ));
}
