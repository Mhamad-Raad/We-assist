import 'package:flutter/cupertino.dart';

class UserPrv extends ChangeNotifier {
  String name = "";
  String phone = "";
  String address = "";
  String usertype = "";
  String email = "";
  String id = "";
  double latitute = 35.5466;
  double longitude = 45.3004;

  addLatitude(double latitude) {
    this.latitute = latitude;
  }

  addLongtitude(double longitude) {
    this.longitude = longitude;
  }

  addId(String id) {
    this.id = id;
    notifyListeners();
  }

  addEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  addName(String name) {
    this.name = name;
    notifyListeners();
  }

  addPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  addAddress(String address) {
    this.address = address;
    notifyListeners();
  }

  addUserType(String usertype) {
    this.usertype = usertype;
    notifyListeners();
  }

  getLatitude() {
    return this.latitute;
  }

  getLongitude() {
    return this.longitude;
  }

  getEmail() {
    return this.email;
  }

  getId() {
    return id;
  }

  getName() {
    return name;
  }

  getPhone() {
    return this.phone;
  }

  getUsertype() {
    return this.usertype;
  }

  getAddress() {
    return this.address;
  }
}
