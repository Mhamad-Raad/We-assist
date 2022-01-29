import 'package:finalmap/view_model/coprofile.dart';
import 'package:finalmap/view/homepage.dart';
import 'package:finalmap/model/usp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'freeprofile.dart';

class cosuc extends StatelessWidget {
  const cosuc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var up = Provider.of<UserPrv>(context, listen: true);

    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 207, 212, 1),
      body: Column(
        children: [
          SizedBox(
            height: height * .1,
          ),
          Center(
            child: Container(
              width: width * .9,
              height: height * .8,
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 110, 130, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .04,
                    ),
                    Text(
                      "Your Order has been posted \n             Successfully",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: height * .09,
                    ),
                    Center(
                      child: Container(
                        width: width * .7,
                        child: Image.network(
                            "https://www.pngall.com/wp-content/uploads/8/Green-Check-Mark-PNG-Image.png"),
                      ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 15,
                        shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                        primary: Color.fromRGBO(191, 207, 212, 1),
                        fixedSize: Size(width * .5, height * .06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        if (up.getUsertype() == "Contractor") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => postOrder(),
                              builder: (context) => coprofile(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => postOrder(),
                              builder: (context) => freeprofile(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
