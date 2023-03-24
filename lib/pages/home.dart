// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authService.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
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
              Navigator.pop(context);
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

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            // title: Text('Issues Near You'),
            title: Text(FirebaseAuth.instance.currentUser!.displayName!),
            actions: <Widget>[
              // Container(
              //   margin: EdgeInsets.all(8.0),
              //   child: CircleAvatar(
              //     backgroundImage: AssetImage('asset/sidePortriat.jpg'),
              //     backgroundImage: NetworkImage(
              //         'FirebaseAuth.instance.currentUser!.photoURL!'),

              //   ),

              // ),
              GestureDetector(
                onTap: () {
                  showOptions(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'FirebaseAuth.instance.currentUser!.photoURL!'),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: List.generate(15, (index) {
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        width: 378,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      'Issue Type',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'Distance',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 160,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                child: Container(
                                  width: 100,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.greenAccent,
                                  ),
                                  child: Center(child: Text('In progress')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                }),
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
                  onPressed: () {},
                ),
                SizedBox(width: 32.0),
                SizedBox(width: 32.0),
                IconButton(
                  iconSize: 40.0,
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
        ));
  }
}
