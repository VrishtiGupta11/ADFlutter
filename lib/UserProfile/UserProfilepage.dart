import 'package:adf2021/ImagePickerTask.dart';
import 'package:adf2021/Model/UserPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  // var docs;
  String? imageURl;
  AppUser? appUser;

  fetchUserDetails() async{
    print("fetch user details");
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentSnapshot document = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    // appUser = AppUser();
    // appUser!.uid = document.get('uid').toString();
    // appUser!.name = document.get('name').toString();
    // appUser!.email = document.get('email').toString();
    // appUser!.imageURL = document.get('imageURL').toString();
    // appUser!.isAdmin = document.get('isAdmin');

    appUser = AppUser(
        name: document.get('name').toString(),
        email: document.get('email').toString(),
        uid: document.get('uid').toString(),
        isAdmin: document.get('isAdmin'),
    );
    return appUser;
  }


  // Stream<DocumentSnapshot> fetchUserDetails(){
  //   String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //   return FirebaseFirestore.instance.collection("user").doc(uid).snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchUserDetails(),
        builder: (context, snapshot) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(8)),
                    // InkWell(
                    //   child: CircleAvatar(
                    //     backgroundColor: null,
                    //     radius: 100,
                    //     child: Image.network(imageURl!),
                    //   ),
                    //   onTap: (){
                    //     Navigator.pushNamed(context, '/imagePicker');
                    //   },
                    // ),
                    ImagePickerPage(),
                    Padding(padding: EdgeInsets.all(8)),
                    Divider(),
                    // StreamBuilder<DocumentSnapshot>(
                    //   stream: fetchUserDetails(),
                    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //       if(snapshot.hasData){
                    //         Map<String, dynamic> documentFields = snapshot.data.data;
                    //         return Text(documentFields['name'], style: TextStyle(color: Colors.blueGrey, fontSize: 20),);
                    //     }
                    //       return Container();
                    //     },
                    // ),
                    Text(appUser!.name.toString() , style: TextStyle(color: Colors.blueGrey, fontSize: 20),),
                    Text(appUser!.email.toString(), style: TextStyle(color: Colors.black38, fontSize: 18),),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Manage Profile",),
                subtitle: Text("Update Your Data for your Account"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("Manage Orders",),
                subtitle: Text("Manage your order history here"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Manage Addresses",),
                subtitle: Text("Update Your Address for your delivery"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text("Help",),
                subtitle: Text("Raise your queries"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.document_scanner_outlined),
                title: Text("Terms and Conditions",),
                subtitle: Text("Check our Terms and Conditions"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
              ),
            ],
          );
        },
      ),

      // body: StreamBuilder(
      //   stream: fetchUserDetails(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if(snapshot.hasData){
      //       Map<String, dynamic> documentFields = snapshot.data.data;
      //       return ListView(
      //         padding: EdgeInsets.all(16),
      //         children: [
      //           Card(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Padding(padding: EdgeInsets.all(8)),
      //                 InkWell(
      //                   child: CircleAvatar(
      //                     backgroundColor: null,
      //                     radius: 100,
      //                   ),
      //                   onTap: (){
      //                     // Image Picker logic
      //                   },
      //                 ),
      //                 Padding(padding: EdgeInsets.all(8)),
      //                 Divider(),
      //                 Text(documentFields['name'].toString() , style: TextStyle(color: Colors.blueGrey, fontSize: 20),),
      //                 Text(documentFields['email'].toString(), style: TextStyle(color: Colors.black38, fontSize: 18),),
      //               ],
      //             ),
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.person),
      //             title: Text("Manage Profile",),
      //             subtitle: Text("Update Your Data for your Account"),
      //             trailing: Icon(Icons.keyboard_arrow_right),
      //             onTap: (){},
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.shopping_cart),
      //             title: Text("Manage Orders",),
      //             subtitle: Text("Manage your order history here"),
      //             trailing: Icon(Icons.keyboard_arrow_right),
      //             onTap: (){},
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.home),
      //             title: Text("Manage Addresses",),
      //             subtitle: Text("Update Your Address for your delivery"),
      //             trailing: Icon(Icons.keyboard_arrow_right),
      //             onTap: (){},
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.message),
      //             title: Text("Help",),
      //             subtitle: Text("Raise your queries"),
      //             trailing: Icon(Icons.keyboard_arrow_right),
      //             onTap: (){},
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.document_scanner_outlined),
      //             title: Text("Terms and Conditions",),
      //             subtitle: Text("Check our Terms and Conditions"),
      //             trailing: Icon(Icons.keyboard_arrow_right),
      //             onTap: (){},
      //           ),
      //         ],
      //       );
      //     }else{
      //       return Text('No data');
      //     }
      //   },
      // ),

    );
  }
}
