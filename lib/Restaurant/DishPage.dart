import 'package:adf2021/CustomWidgets/Counter.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DishPage extends StatefulWidget {

  String? restaurantID;

  DishPage({Key? key, this.restaurantID}) : super(key: key);

  @override
  _DishPageState createState() => _DishPageState();
}


class _DishPageState extends State<DishPage> {

  Map? cartMap;

  fetchDishes(){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("restaurants").doc(widget.restaurantID).collection('dishes').snapshots();
    return stream;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(Util.APP_NAME),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/cart');
          }, icon: Icon(Icons.shopping_cart)),
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder(
        stream: fetchDishes(),
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
          return ListView(
              children: snapshot.data.docs.map<Widget>((DocumentSnapshot document){
                Map<String, dynamic> map = document.data() as Map<String, dynamic>;
                map['docID'] = document.id.toString();

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 320,
                        width: 320,
                        margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                            color: Colors.grey,
                            // offset: Offset(0.0, 1.0),
                            blurRadius: 10,
                          )],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                child: Column(
                                  children: [
                                    // Image.network(
                                    //   map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'],
                                    // ),
                                    FadeInImage.assetNetwork(
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
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text(map['name']),
                                        Spacer(),
                                        Container(
                                          height: 28,
                                          width: 50,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(map['ratings'].toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                              Icon(Icons.star, color: Colors.white, size: 15,)
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.green[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                              subtitle: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(map['discountType'].toString()),
                                        Spacer(),
                                        Text("\u20b9${map['price'].toString()}", style: TextStyle(color: Colors.grey),),
                                      ],
                                    ),
                                    // Counter(dish: cartMap,),
                                    Counter(dish: map,),
                                  ],
                                )
                              ),
                              onTap: (){},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );

                // return Card(
                //       elevation: 3,
                //       child: Container(
                //         padding: EdgeInsets.all(10),
                //         child: Column(
                //           children: [
                //             Image.network(map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'],),
                //             ListTile(
                //               title: Text(map['name']),
                //               trailing: Container(
                //                 child: Column(
                //                   children: [
                //                     Container(
                //                       height: 28,
                //                       width: 50,
                //                       child: Row(
                //                         mainAxisAlignment: MainAxisAlignment.center,
                //                         crossAxisAlignment: CrossAxisAlignment.center,
                //                         children: [
                //                           Text(map['ratings'].toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                //                           Icon(Icons.star, color: Colors.white, size: 15,)
                //                         ],
                //                       ),
                //                       decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.circular(8),
                //                         color: Colors.green[800],
                //                       ),
                //                     ),
                //                     SizedBox(height: 6,),
                //                     Text("\u20b9${map['price']}", style: TextStyle(color: Colors.grey),),
                //                   ],
                //                 ),
                //               ),
                //               subtitle: Text(map['discountType'].toString()),
                //               onTap: (){},
                //             ),
                //           ],
                //         ),
                //       ),
                //     );

              }).toList(),
            );
        },
      ),
    );
  }
}
