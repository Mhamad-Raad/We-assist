import 'package:finalmap/view/Register.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'Login.dart';

class Loading_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    Widget example1 = SplashScreenView(
        navigateRoute: const Choose(),
        duration: 5000,
        imageSize: 150,
        imageSrc: "assets/images/MAP_logo.png",
        text: "We are Here to Assist (YOU <3)",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
          fontSize: w * .09,
        ),
        backgroundColor: const Color.fromRGBO(18, 110, 130, 1));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lock',
      home: example1,
    );
  }
}

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 207, 212, 1),
      body: Column(
        children: [
          Container(
            height: height * .45,
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
            height: height * .15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 15,
              shadowColor: const Color.fromRGBO(0, 0, 0, 1),
              primary: Color.fromRGBO(18, 110, 130, 1),
              fixedSize: Size(width * .65, height * .08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: height * .075),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 15,
              shadowColor: const Color.fromRGBO(0, 0, 0, 1),
              primary: Color.fromRGBO(18, 110, 130, 1),
              fixedSize: Size(width * .65, height * .08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
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
    );
  }
}
