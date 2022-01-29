import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalmap/view/freeprofile.dart';
import 'package:finalmap/model/usp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../view_model/coprofile.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String iD = "";
  late var lat, lng;

  @override
  initState() {
    super.initState();
    Timer(Duration(seconds: 1), () async {
      WidgetsBinding.instance?.addObserver(this);
    });
    setStatus("online");
    getlocation();
  }

  void setStatus(String status) async {
    await firestore.collection('users').doc(iD).update({"status": status});
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      //online

      setStatus("online");
    } else {
      //offline

      setStatus("offline");
    }
  }

  getlocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        getlocation();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        getlocation();
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      lng = _locationData.longitude;
      lat = _locationData.latitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    var up = Provider.of<UserPrv>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Future<bool> check() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return false;
        } else if (e.code == 'wrong-password') {
          return false;
        }
      }
      return false;
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 207, 212, 1),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: [
              Container(
                height: height * .25,
                width: width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(18, 110, 130, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(60.0),
                  ),
                ),
                child: Center(
                  child: Image.asset('assets/images/MAP_logo.png'),
                ),
              ),
              SizedBox(
                height: height * .25,
              ),
              Text(
                "Sign in",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * .03,
              ),
              SizedBox(
                width: width * .8,
                height: height * .07,
                child: TextFormField(
                  controller: emailController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Email",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(18, 110, 130, 1),
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(18, 110, 130, 1), width: 0),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val?.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              SizedBox(
                width: width * .8,
                height: height * .07,
                child: TextFormField(
                  controller: passwordController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Password",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(18, 110, 130, 1),
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(18, 110, 130, 1),
                        width: 0,
                      ),
                    ),

                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val?.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(
                height: height * .058,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 15,
                  shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                  primary: Color.fromRGBO(18, 110, 130, 1),
                  fixedSize: Size(width * .6, height * .07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () async {
                  if (await check()) {
                    var up = Provider.of<UserPrv>(context, listen: false);

                    FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: emailController.text)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        up.addAddress(element.data()['Address']);
                        up.addEmail(element.data()['email']);
                        up.addName(element.data()['name']);
                        up.addPhone(element.data()['phone']);
                        up.addUserType(element.data()['usertype']);
                        up.addLatitude(element.data()['latitude']);
                        up.addLongtitude(element.data()['longitude']);
                      });
                    });

                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection("users")
                        .get();

                    int i = 0;
                    querySnapshot.docs.forEach((element) {
                      if (element['email'] == up.getEmail()) {
                        up.addId(querySnapshot.docs[i].id);
                      }
                      i++;
                    });

                    setState(() {
                      iD = up.getId();
                    });
                  }
                  ;

                  await firestore
                      .collection('users')
                      .doc(up.getId())
                      .update({"status": "online"});

                  await firestore
                      .collection('users')
                      .doc(up.getId())
                      .update({"latitude": lat, 'longitude': lng});

                  if (up.getUsertype() == "Contractor") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => coprofile(),
                      ),
                    );
                  } else if (up.getUsertype() == "Freelancer") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => freeprofile(),
                        ));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
