import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../view_model/coprofile.dart';
import 'cosuccessful.dart';

// ignore: must_be_immutable
class ViewOrder extends StatefulWidget {
  late var ownername, name;
  ViewOrder({this.ownername, this.name});

  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Location location = new Location();
  late var lat = 35.5466, lng = 45.3004;
  late var olat = 35.5467, olng = 45.3004;

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  initState() {
    super.initState();
    print(widget.name + widget.ownername);
    Timer(Duration(seconds: 10), () {
      getlocation();
      getolocation();
    });
  }

  getolocation() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await users.get();

    int i = 0;
    // ignore: unused_local_variable
    String id = "";
    querySnapshot.docs.forEach((element) {
      if (element['name'] == widget.ownername) {
        setState(() {
          olng = element['longitude'];
          olat = element['latitude'];
        });
      }
      i++;
    });
  }

  getlocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }
    _locationData = await location.getLocation();
    setState(() {
      lng = _locationData.longitude!;
      lat = _locationData.latitude!;
    });

    QuerySnapshot q = await users.get();

    int i = 0;
    // ignore: unused_local_variable
    String id = "";
    q.docs.forEach((element) {
      if (element['name'] == widget.name) {
        setState(() {
          id = q.docs[i].id;
        });
      }
      i++;
    });

    firestore
        .collection('users')
        .doc(id)
        .update({"latitude": lat, 'longitude': lng});
  }

  @override
  Widget build(BuildContext context) {
    getlocation();
    var marker = <Marker>[];

    marker = [
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(lat, lng),
        builder: (ctx) => Icon(
          Icons.pin_drop,
          size: 30,
          color: Color.fromRGBO(18, 110, 130, 1),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(olat, olng),
        builder: (ctx) => Icon(
          Icons.pin_drop,
          size: 30,
          color: Colors.red,
        ),
      ),
    ];

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options:
                      MapOptions(center: LatLng(35.5558, 45.4351), zoom: 11),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: marker,
                    ),
                    new PolylineLayerOptions(
                      polylines: [
                        new Polyline(
                            points: [LatLng(lat, lng), LatLng(olat, olng)],
                            strokeWidth: 2.0,
                            color: Colors.red)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 150),
        child: Row(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () async {
                print(widget.ownername + widget.name);
                QuerySnapshot querySnapshot =
                    await FirebaseFirestore.instance.collection("orders").get();
                int i = 0;
                querySnapshot.docs.forEach((element) async {
                  if (element['ownername'] == widget.ownername &&
                      element['taker'] == widget.name) {
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(querySnapshot.docs[i].id)
                        .update({'orderstat': "done"});
                  }
                  i++;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cosuc(),
                  ),
                );
              },
              child: Icon(Icons.check),
            ),
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => coprofile(),
                  ),
                );
              },
              child: Icon(Icons.cancel_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
