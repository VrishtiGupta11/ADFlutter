import 'dart:async';

import 'package:adf2021/Model/UserPage.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{
  FirebaseFirestore? db;
  AppUser? appUser;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? restaurantSubscription;
  List<QueryDocumentSnapshot>? restaurants;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? orderSubscription;
  List<QueryDocumentSnapshot>? orders;

  DataProvider(){
    db = FirebaseFirestore.instance;
    // getAppUser();
    // fetchRestaurants();
    fetchOrders();
  }

  getAppUser() async{
    print("fetch user details");
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null) {
      print('Data Provider UID = ${user.uid}');
      DocumentSnapshot document = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
      appUser = AppUser();
      appUser!.uid = document.get('uid').toString();
      appUser!.name = document.get('name').toString();
      appUser!.email = document.get('email').toString();
      appUser!.imageURL = document.get('imageURL').toString();
      appUser!.isAdmin = document.get('isAdmin');
    }
  }

  fetchRestaurants(){
    // Listen will observe for any data change in database and hence th function will be re-executed to handle changes
    restaurantSubscription = db!.collection('restaurants').snapshots().listen((event) {
    restaurants = event.docs;
    print("Data: ${event.docs.first.data()}");
    notifyListeners();
    });
  }

  fetchOrders(){
    orderSubscription = db!.collection('users').doc(Util.appUser!.uid).collection('orders').snapshots().listen((event) {
      print("Data: ${event.docs.first.data()}");
      orders = event.docs;
      notifyListeners();
    });
  }
}