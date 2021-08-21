import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {

  String imagePath = "NA";
  String userPhone = "9999988888";
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('profile-pics/'+userPhone+'.png')
          .putFile(file);
          print("UPLOAD SUCCESS");
    } on FirebaseException catch (e) {
      print("UPLOAD FAILED");
    }
  }

  getImage() async{
    var image = await FirebaseStorage.instance
        .ref('profile-pics/'+userPhone+'.png').getDownloadURL();
    print("Image URL -> "+image);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
        future: getImage(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(
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
                      imagePath = snapshot.data.toString();
                      // return imagePath;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: null,
                    radius: 100,
                    backgroundImage: NetworkImage(imagePath),
                  ),
                ),
              ],
            );
          }
          else{
            print("Loading data");
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
