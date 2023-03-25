import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authService.dart';

class googleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GHome(),
    );
  }
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

class GHome extends StatefulWidget {
  @override
  _GHomeState createState() => _GHomeState();
}

class _GHomeState extends State<GHome> {
  String googleApikey = "GOOGLE_MAP_API_KEY";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(8.9806, 38.7578); //addis ababa coordinates
  String location = "Location Name:";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 125, 139, 1),
          title: Text('Location Picker'),
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
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona; //when map is dragging
            },
            onCameraIdle: () async {
              //when map drag stops
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              setState(() {
                //get place name from lat and lang
                location = placemarks.first.administrativeArea.toString() +
                    ", " +
                    placemarks.first.street.toString();
              });
            },
          ),
          Center(
            //picker image on google map
            child: Image.asset(
              "asset/picker.png",
              width: 80,
            ),
          ),
          Positioned(
              //widget to display location name
              bottom: 100,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: ListTile(
                        leading: Image.asset(
                          "assets/picker.png",
                          width: 25,
                        ),
                        title: Text(
                          location,
                          style: TextStyle(fontSize: 18),
                        ),
                        dense: true,
                      )),
                ),
              ))
        ]));
  }
}
