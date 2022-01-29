import 'package:finalmap/view/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool usertype = true;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'Address': addressController.text,
            'phone': phoneController.text,
            'usertype': usertype ? "Contractor" : "Freelancer",
            'status': 'offline',
            'latitude': 35.5466,
            'longitude': 45.3004
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> register() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                height: height * .05,
              ),
              SizedBox(
                width: width * .8,
                height: height * .07,
                child: TextFormField(
                  controller: nameController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Name",
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
                  controller: passwordController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   password",
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
                  controller: addressController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Address",
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
                  controller: phoneController,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    labelText: "   Phone",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio<int>(
                          value: 0,
                          groupValue: index,
                          onChanged: (val) {
                            setState(() {
                              index = val!;
                              usertype = false;
                            });
                          }),
                      const Text(
                        'Freelancer',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                          value: 1,
                          groupValue: index,
                          onChanged: (val) {
                            setState(() {
                              index = val!;
                              usertype = true;
                            });
                          }),
                      const Text(
                        'Contracor',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
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
                  register();
                  addUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: const Text(
                  'Register',
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

  int index = 1;
}
