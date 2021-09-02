import 'dart:io';

import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {

  String imagePath = Util.appUser!.imageURL.toString();
  String userPhone = "9999988888";
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('profile-pics/'+userPhone+'.png')
          .putFile(file);
      await FirebaseStorage.instance
          .ref('profile-pics/'+userPhone+'.png').getDownloadURL().then((value) => imagePath = value.toString());
      print(imagePath);
      print("UPLOAD SUCCESS");
      // setState(() {});

      setState(() {
        copyToDatabase();
      });

    } on FirebaseException catch (e) {
      print("UPLOAD FAILED");
    }
  }
  
  copyToDatabase(){
    FirebaseFirestore.instance.collection('users').doc(Util.appUser!.uid).update(
        {'imageURL' : imagePath});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Image.network(imagePath),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
                uploadFile(image!.path);
                setState(() {
                  imagePath = Util.appUser!.imageURL.toString();
                });
                },
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10
                  )]
                ),
                child: imagePath==""? Icon(Icons.account_circle, size: 160, color: Colors.grey.shade50,) : CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(imagePath.toString()),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
