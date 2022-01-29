import 'package:finalmap/model/usp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/Choose.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserPrv(),
      child: MaterialApp(
        home: Loading_Screen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
