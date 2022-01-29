import 'package:finalmap/view/profile.dart';
import 'package:finalmap/model/usp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/Dashboard.dart';
import '../view/homepage.dart';

// ignore: must_be_immutable
class coprofile extends StatefulWidget {
  @override
  State<coprofile> createState() => _coprofileState();
}

class _coprofileState extends State<coprofile> {
  int currentindex = 2;

  static List screen = [
    Dashboard(),
    homepage(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    var up = Provider.of<UserPrv>(context, listen: true);
    return Scaffold(
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
