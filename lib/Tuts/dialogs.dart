import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlertDialogPage extends StatefulWidget {
  var docId;
  AlertDialogPage({Key? key, this.docId}) : super(key: key);

  @override
  _AlertDialogPageState createState() => _AlertDialogPageState();
}

class _AlertDialogPageState extends State<AlertDialogPage> {

  // DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.delete, color: Colors.grey,),
        onPressed: () async{
          return showDialog(
            barrierDismissible: false,
            // barrierColor: Colors.redAccent.shade100,
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Delete Address'),
                content: Container(
                  height: 50,
                  child: Column(
                    children: [
                      Text('Are you sure you want to Delete this Address?', style: TextStyle(color: Colors.grey),),
                      // SizedBox(height: 4.0,),
                      // Text(''),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel', style: TextStyle(color: Colors.redAccent.shade100),),
                  ),
                  TextButton(
                    onPressed: (){
                      FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('addresses').doc(widget.docId).delete();
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete', style: TextStyle(color: Colors.redAccent.shade100),),
                  ),
                ],
              );
              // return DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now());
            }
          );
        },
      ),
    );
  }
}
