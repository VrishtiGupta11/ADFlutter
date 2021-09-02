import 'package:adf2021/Model/UserPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Util{
  static String APP_NAME = 'Foodie';
  static AppUser? appUser;

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