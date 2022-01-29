import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Post.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late var name = ["", "", "", "", "", "", "", "", "", ""];
  late var address = ["", "", "", "", "", "", "", "", "", ""];

  late int count;
  int c = 0;
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  getOrders() async {
    count = 0;

    await firestore
        .collection("users")
        .where('usertype', isEqualTo: 'Freelancer')
        .where('status', isEqualTo: 'online')
        .get()
        .then((q) {
      q.docs.forEach((element) {
        setState(() {
          name[count] = element['name'];
          address[count] = element['Address'];

          count = count + 1;
        });

        setState(() {
          c = count;
        });
      });
    });
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 207, 212, 1),
      body: Column(
        children: [
          SizedBox(height: height * 0.2),
          Center(
            child: Container(
              width: width * .9,
              height: height * .5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 110, 130, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 120, top: 10),
                    child: Text(
                      "Users Online ${c}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    itemCount: c,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color.fromRGBO(191, 207, 212, 1),
                        ),
                        margin: EdgeInsets.all(15),
                        height: 125.0,
                        width: 230.0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              name[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              address[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 15,
              shadowColor: const Color.fromRGBO(0, 0, 0, 1),
              primary: Color.fromRGBO(18, 110, 130, 1),
              fixedSize: Size(width * .5, height * .06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => postOrder(),
                ),
              );
            },
            child: Text(
              'Post Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
