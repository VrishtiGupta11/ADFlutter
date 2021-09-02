import 'package:adf2021/CustomWidgets/Counter.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  fetchCart(){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('cart').snapshots();
    return stream;
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchCart(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              title: Text(Util.APP_NAME),
              centerTitle: true,
              backgroundColor: Colors.redAccent.shade100,
              actions: [
                IconButton(onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                }, icon: Icon(Icons.logout)),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/profile');
                }, icon: Icon(Icons.person)),
              ],
            ),
            body: Center(
              child: Text('No Dish available in Cart', style: TextStyle(color: Colors.grey),),
            ),
          );
        }

        else{
          return Scaffold(
            appBar: AppBar(
              title: Text('My Cart'),
              centerTitle: true,
              backgroundColor: Colors.redAccent.shade100,
              actions: [
                IconButton(onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                }, icon: Icon(Icons.logout)),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/profile');
                }, icon: Icon(Icons.person)),
              ],
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //   items: [
            //
            //   ],
            // ),
            body: ListView(
              children: snapshot.data.docs.map<Widget>((DocumentSnapshot document){
                Map<String, dynamic> map = document.data() as Map<String, dynamic>;
                int len = snapshot.data.docs.length;
                print(len);
                map['docID'] = document.id.toString();

                return Container(
                  // height: 300,
                  width: 100,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(blurRadius: 5)],

                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        // child: Image.network(map['imageURL'],),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'loader.gif',
                          image: map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'],
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text('Image Not Available'),
                            );
                          },
                          placeholderErrorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text('Loading Image'),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(map['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  Text(map['totalPrice'].toString(), style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            Spacer(),
                            Counter(dish: map,),
                            // CounterWidget(dish: map,),
                          ],
                        ),
                      ),

                    ],
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