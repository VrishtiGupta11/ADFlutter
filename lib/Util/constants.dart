import 'package:adf2021/Model/UserPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';

class Util{
  static String APP_NAME = 'Foodie';
  static AppUser? appUser;

  static Future<bool> isInternetConnected() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }

  static fetchUserDetails() async{
    print("fetch user details");
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentSnapshot document = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Util.appUser = AppUser();
    Util.appUser!.uid = document.get('uid').toString();
    Util.appUser!.name = document.get('name').toString();
    Util.appUser!.email = document.get('email').toString();
    Util.appUser!.imageURL = document.get('imageURL').toString();
    Util.appUser!.isAdmin = document.get('isAdmin');
  }
}