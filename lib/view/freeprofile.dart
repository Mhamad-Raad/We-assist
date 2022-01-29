import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'freedashboard.dart';
import 'freehomepage.dart';
import 'profile.dart';
import '../model/usp.dart';

// ignore: must_be_immutable
class freeprofile extends StatefulWidget {
  @override
  _freeprofileState createState() => _freeprofileState();
}

class _freeprofileState extends State<freeprofile> {
  int currentindex = 2;
  static List screen = [
    freedashboard(),
    freehomepage(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.red,
      // ),
      backgroundColor: Color.fromRGBO(191, 207, 212, 1),
      body: screen[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(18, 110, 130, 1),
        currentIndex: currentindex,
        selectedItemColor: Colors.white,
        //  showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 25,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_sharp),
            label: "dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: "Profile"),
        ],
      ),
    );
  }
}
