// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print
import 'package:flutter/material.dart';
import 'authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detail {
  final String title;
  final String description;
  final String location;
  final String imageurl;

  const Detail(this.title, this.description, this.location, this.imageurl);
}

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

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _issueStream =
      FirebaseFirestore.instance.collection('issues').snapshots();
  late final List<Detail> detailInfo;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String location1 = '';
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
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
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _issueStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = snapshot.requireData;
                void _sendDataToDetailScreen(BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          text: location1,
                        ),
                      ));
                }

                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        location1 = data.docs[index].get('location');
                        _sendDataToDetailScreen(context);
                      },
                      child: Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 16.0),
                                        child: Text(
                                          data.docs[index].get('category'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          data.docs[index].get('location'),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            width: 85,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: (data.docs[index]
                                                          .get('status') ==
                                                      'In progress')
                                                  ? Colors.yellow
                                                  : (data.docs[index]
                                                              .get('status') ==
                                                          'pending')
                                                      ? Colors.red
                                                      : Colors.greenAccent,
                                            ),
                                            child: Center(
                                                child: Text(data.docs[index]
                                                    .get('status'))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    );
                  },
                );
              },
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

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    late Stream<QuerySnapshot> _issueStream = FirebaseFirestore.instance
        .collection('issues')
        .where('location', isEqualTo: text)
        .snapshots();
    var vote = 0;

    void incVote() {
      vote++;
    }

    void decVote() {
      vote--;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Issues in $text'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _issueStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot issue = snapshot.data!.docs[index];
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        issue.get('category'),
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
                            issue.get('imageUrl'),
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
                        issue.get('description'),
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
                        issue.get('location'),
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
                          icon: Icon(Icons.arrow_upward,
                              size: 35, color: Colors.green),
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
              );
            },
          );
        },
      ),
    );
  }
}
