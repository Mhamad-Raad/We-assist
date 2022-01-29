import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalmap/model/usp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Choose.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String iD = "";
  bool status = false;
  @override
  Widget build(BuildContext context) {
    var up = Provider.of<UserPrv>(context, listen: true);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: height * .18,
                width: width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(18, 110, 130, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(60.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: Image.asset(
                          'assets/images/MAP_logo.png',
                          scale: 1.5,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        width: 100,
                        height: 60,
                        margin: EdgeInsets.only(left: 300.0, top: 30),
                        child: Image.asset(
                          'assets/images/ruler.png',
                          scale: 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .040,
              ),
              Container(
                child: Image.asset('assets/girl.png'),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: height * .009,
              ),
              Text(
                "${up.getName()}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: height * .020,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0), //or 15.0
                child: Container(
                  height: 310.0,
                  width: 350.0,

                  decoration: BoxDecoration(
                    color: Color.fromRGBO(18, 110, 130, 1),
                  ),

                  //white boxes info
                  child: Column(
                    children: [
                      //  borderRadius: BorderRadius.circular(40.0),//or 15.0
                      Container(
                        height: 50.0,
                        width: 230.0,
                        child: Center(
                          child: Text(
                            "Phone: " + up.phone,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 0, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                      ),

                      Container(
                        height: 50.0,
                        width: 230.0,
                        child: Center(
                          child: Text(
                            "User Type: " + up.getUsertype(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 0, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                      ),

                      Container(
                        height: 50.0,
                        width: 230.0,
                        child: Center(
                          child: Text(
                            "Email : " + up.getEmail(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 0, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                      ),

                      Container(
                        height: 50.0,
                        width: 230.0,
                        child: Center(
                          child: Text(
                            "Address :" + up.getAddress(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 0, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .037,
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

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Choose()));

                    setState(() {
                      iD = up.getId();
                      status = false;
                      print(status);
                    });

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(up.getId())
                        .update({"status": "offline"});
                  },
                  child: Text("logout"))
            ],
          ),
        ),
      ),
    );
  }
}
