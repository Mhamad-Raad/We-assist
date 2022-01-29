import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalmap/view/cosuccessful.dart';
import 'package:finalmap/model/usp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class viewdesc extends StatefulWidget {
  late String title;
  late String stat;
  late String ownername;
  late String ownerphone;
  late String description;
  late String payment;
  late String location;
  late String time;
  late String orderid;
  late String taken;

  viewdesc(
      {required this.title,
      required this.stat,
      required this.ownername,
      required this.ownerphone,
      required this.description,
      required this.payment,
      required this.location,
      required this.time,
      required this.orderid,
      required this.taken});

  @override
  State<viewdesc> createState() => _viewdescState();
}

class _viewdescState extends State<viewdesc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var up = Provider.of<UserPrv>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 207, 212, 1),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(18, 110, 130, 1),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(height: height * 0.08),
            Container(
              padding: EdgeInsets.all(10),
              height: height * .8,
              width: width * .8,
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 110, 130, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    widget.description,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Owner Name: " + widget.ownername,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Owner Phone: " + widget.ownerphone,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Owner Payment: " + widget.payment,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Process Time: " + widget.time,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Delivery location: " + widget.location,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "status: " + widget.stat,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: height * .3,
                  ),
                  (widget.taken == "false" || up.getUsertype() == "Contractor")
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 15,
                            shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                            primary: Colors.amber,
                            fixedSize: Size(width * .5, height * .06),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            _showDialog(context, widget.title, widget.time,
                                up.getName());
                          },
                          child: Text(
                            'Accept Order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Text(""),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context, var title, time, name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Text(time),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text(
                'ACCEPT',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                QuerySnapshot querySnapshot =
                    await FirebaseFirestore.instance.collection("orders").get();
                int i = 0;
                querySnapshot.docs.forEach((element) async {
                  if (element['ownername'] == widget.ownername &&
                      element['orderid'] == widget.orderid) {
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(querySnapshot.docs[i].id)
                        .update({
                      'taker': name,
                      'taken': "true",
                      'orderstat': 'ongoing'
                    });
                  }
                  i++;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cosuc(),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
