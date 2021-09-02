import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  String? uid;
  String? name;
  String? email;
  bool? isAdmin;
  String? imageURL;
  GeoPoint? currentLocation;

  AppUser({this.uid, this.name, this.email, this.isAdmin});

  @override
  String toString() {
    return 'User{uid: $uid, name: $name, email: $email, isAdmin: $isAdmin, imageURL: $imageURL, currentLocation: $currentLocation}';
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "isAdmin": isAdmin,
      "imageURL": imageURL,
      "currentLocation": currentLocation,
    };
  }

}