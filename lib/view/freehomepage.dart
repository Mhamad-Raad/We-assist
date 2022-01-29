import 'package:finalmap/view/viewdesc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class freehomepage extends StatefulWidget {
  const freehomepage({Key? key}) : super(key: key);

  @override
  State<freehomepage> createState() => _freehomepageState();
}

class _freehomepageState extends State<freehomepage> {
  late var titles = ["", "", "", "", "", "", "", "", "", ""];
  late var stat = ["", "", "", "", "", "", "", "", "", ""];
  late var ownername = ["", "", "", "", "", "", "", "", "", ""];
  late var ownerphone = ["", "", "", "", "", "", "", "", "", ""];
  late var description = ["", "", "", "", "", "", "", "", "", ""];
  late var payment = ["", "", "", "", "", "", "", "", "", ""];
  late var location = ["", "", "", "", "", "", "", "", "", ""];
  late var time = ["", "", "", "", "", "", "", "", "", ""];
  late var orderid = ["", "", "", "", "", "", "", "", "", ""];
  late var taken = ["", "", "", "", "", "", "", "", "", ""];

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
        .collection("orders")
        .where('taken', isEqualTo: 'false')
        .get()
        .then((q) {
      q.docs.forEach((element) {
        setState(() {
          titles[count] = element['title'];
          stat[count] = element['orderstat'];
          ownername[count] = element['ownername'];
          ownerphone[count] = element['ownerphone'];
          description[count] = element['description'];
          payment[count] = element['payment'];
          location[count] = element['location'];
          time[count] = element['time'];
          orderid[count] = element['orderid'];
          taken[count] = element['taken'];

          count = count + 1;
        });

        setState(() {
          c = count;
        });
      });
    });
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
                      "Order Count ${c}",
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
                              titles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ownername[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 100, top: 40),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 15,
                                  shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                                  primary: Color.fromRGBO(18, 110, 130, 1),
                                  fixedSize: Size(width * .3, height * .04),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => viewdesc(
                                        title: titles[index],
                                        stat: stat[index],
                                        ownername: ownername[index],
                                        ownerphone: ownerphone[index],
                                        description: description[index],
                                        payment: payment[index],
                                        location: location[index],
                                        time: time[index],
                                        orderid: orderid[index],
                                        taken: taken[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'View Description',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
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
        ],
      ),
    );
  }
}
