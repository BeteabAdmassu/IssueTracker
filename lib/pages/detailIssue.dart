import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authService.dart';

class IssueDetails extends StatefulWidget {
  @override
  _IssueDetailsState createState() => _IssueDetailsState();
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
              // Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

class _IssueDetailsState extends State<IssueDetails> {
  var vote = 0;

  void incVote() {
    setState(() {
      vote++;
    });
  }

  void decVote() {
    setState(() {
      vote--;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(96, 125, 139, 1),
        title: Text('Issues Near You'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pothole',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac velit eu lectus sollicitudin interdum. Integer id risus consequat, luctus magna nec, dictum risus. Duis pharetra, netus et malesuada fames ac turpis egestas. Donec sit amet ex id justo pretium iaculis ac ut augue. In hac habitasse platea dictumst.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                '123 Main St, Addis Ababa, ETH',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_upward, size: 35, color: Colors.green),
                  onPressed: () {
                    incVote();
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  vote.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_downward,
                    size: 35,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    decVote();
                  },
                ),
              ],
            ),
          ],
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
    );
  }
}
