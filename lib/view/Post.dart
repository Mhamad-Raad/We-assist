import 'package:finalmap/model/usp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'homepage.dart';

class postOrder extends StatefulWidget {
  const postOrder({Key? key}) : super(key: key);

  @override
  _postOrderState createState() => _postOrderState();
}

final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController locationController = TextEditingController();
final TextEditingController timeController = TextEditingController();
final TextEditingController paymentController = TextEditingController();

class _postOrderState extends State<postOrder> {
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    var up = Provider.of<UserPrv>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CollectionReference order = FirebaseFirestore.instance.collection('orders');

    Future<void> addOrder() {
      return order
          .add({
            'title': titleController.text,
            'description': descriptionController.text,
            'location': locationController.text,
            'time': timeController.text,
            'payment': paymentController.text,
            'owner': up.getEmail(),
            'ownerphone': up.getPhone(),
            'orderstat': 'undone',
            'ownername': up.getName(),
            'taken': 'false',
            'taker': '',
            'orderid': "${random.nextInt(1000)}"
          })
          .then((value) => print("order Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 207, 212, 1),
      body: SingleChildScrollView(
        child: SizedBox(
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
                height: height * .03,
              ),
              Center(
                child: Text("please fill order Confirmation"),
              ),
              SizedBox(
                height: height * .05,
              ),
              SizedBox(
                width: width * .8,
                height: height * .07,
                child: TextFormField(
                  controller: titleController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Order Title",
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
                height: height * .02,
              ),
              SizedBox(
                width: width * .8,
                height: height * .07,
                child: TextFormField(
                  controller: descriptionController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Order Decription",
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
                height: height * .02,
              ),
              SizedBox(
                width: width * .8,
                height: height * .07,
                child: TextFormField(
                  controller: locationController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Order Location",
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
                      return "password cannot be empty";
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
                  controller: timeController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Estimated time",
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
                height: height * .02,
              ),
              SizedBox(
                width: width * .8,
                height: height * .07,
                child: TextFormField(
                  controller: paymentController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   payment",
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

                  // validator: (val) => val?.length == 0 ? 'please enter phone number' : null ,
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(
                height: height * .025,
              ),
              SizedBox(
                height: height * .05,
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
                  addOrder();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homepage(),
                    ),
                  );
                },
                child: const Text(
                  'Publish Order',
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
