import 'package:adf2021/UserProfile/add-address.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:adf2021/Tuts/dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UserAddressesPage extends StatefulWidget {
  const UserAddressesPage({Key? key}) : super(key: key);

  @override
  _UserAddressesPageState createState() => _UserAddressesPageState();
}

class _UserAddressesPageState extends State<UserAddressesPage> {

  List<Widget> widgetList = [];

  fetchAddresses(){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('users').doc(Util.appUser!.uid).collection('addresses').snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchAddresses(),
      builder: (BuildContext context,AsyncSnapshot snapshot) {

        if(snapshot.hasError){
          return Center(
            child: Text("Something Went Wrong", style: TextStyle(color: Colors.red),),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data.docs.isEmpty){
          return Scaffold(
            appBar: AppBar(
              title: Text('Addresses'),
              centerTitle: true,
              backgroundColor: Colors.redAccent.shade100,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.add, color: Colors.white,),
              onPressed: (){
                // Open UI To add address
                Navigator.pushNamed(context, '/addAddress');
              },
            ),
            body: Center(
              child: Text('Click on + to ADD Address', style: TextStyle(color: Colors.black54),),
            ),
          );
        }

        else{
          return Scaffold(
            appBar: AppBar(
              title: Text("Addresses"),
              centerTitle: true,
              backgroundColor: Colors.redAccent.shade100,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.add, color: Colors.white,),
              onPressed: (){
                // Open UI To add address
                Navigator.pushNamed(context, '/addAddress');
              },
            ),
            // View the addresses
            body: ListView(
              children: snapshot.data.docs.map<Widget>((DocumentSnapshot document){
                Map map = document.data() as Map;
                map['docID'] = document.id.toString();
                String addressString = '';
                List addressList = map['address'].split(',');

                if(map['address'] == null || map['address'] == 'null' || map['address'] == ''){
                  print('Deleting Null Address');
                  FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('addresses').doc(map['docID']).delete();
                }

                addressList.forEach((element) {
                  // print(element);
                  var addList = element.split('=');
                  // print(addList);
                  if(addList[0].trim() == 'streetAddress' || addList[0].trim() == 'region' || addList[0].trim() == 'countryName' || addList[0].trim() == 'postal'){
                    addressString += element + '\n';
                  }
                });
                return Card(
                  child: ListTile(
                    leading: map['label'] == 'Home Place'? Icon(Icons.home) : Icon(Icons.work),
                    title: Container(
                      child: Column(
                        children: [
                          Row(
                          children: [
                            Text(map['label'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            Spacer(),
                            // IconButton(
                            //   onPressed: (){
                            //     FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('addresses').doc(map['docID']).delete();
                            //   },
                            //   icon: Icon(Icons.delete, color: Colors.grey,),
                            // ),
                            AlertDialogPage(docId: map['docID'],),
                          ],
                        ),
                          SizedBox(height: 10,),
                        ]
                      ),
                    ),
                    subtitle: Container(
                      child: Row(
                        children: [
                          Text(addressString, style: TextStyle(color: Colors.black54),),
                          Spacer(),
                          IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressPage(lat: map['location'].latitude, long: map['location'].longitude,)));
                            },
                            icon: Image.asset('map.png'),
                            iconSize: 50,
                          ),
                        ],
                      ),
                    ),
                    dense: true,

                    // trailing: Image.asset('map.png'),
                    // onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressPage(lat: map['location'].latitude, long: map['location'].longitude,)));
                    // },
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}