import 'package:adf2021/Restaurant/AddDishes.dart';
import 'package:adf2021/Restaurant/DishPage.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {

  var uid = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : "";

  fetchRestaurants(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("restaurants").snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    if(Util.appUser == null){
      Util.fetchUserDetails();
    }
    return StreamBuilder(
        stream: fetchRestaurants(),
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

          // List data = [10, 20, 30];
          // List data1 = data.map((e) => e+10).toList();

          /*List<DocumentSnapshot> snapshots = snapshot.data!.docs;
          List<ListTile> tiles = [];
          snapshots.forEach((document) {
            Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
            tiles.add(
                ListTile(
                  title: Text(map['name']),
                  subtitle: Text(map['categories']),
                )
            )
          });*/

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
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/profile');
                }, icon: Icon(Icons.person)),
              ],
            ),
            body: ListView(
              children: snapshot.data.docs.map<Widget>((DocumentSnapshot document){
                Map<String, dynamic> map = document.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 295,
                        width: 320,
                        margin: EdgeInsets.only(top: 15,bottom: 15, left: 10, right: 10),
                        padding: EdgeInsets.all(10),
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
                            // Image.network(map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'], fit: BoxFit.fill,),

                            ListTile(
                              title: Container(
                                child: Column(
                                  children: [
                                    // Image.network(
                                    //   map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'],
                                    //   loadingBuilder: (context, child, loadingProgress) {
                                    //     if (loadingProgress == null) return child;
                                    //     return Center(
                                    //       child: CircularProgressIndicator(),
                                    //     );
                                    //   },
                                    //   errorBuilder: (context, error, stackTrace) {
                                    //     return Center(
                                    //       child: Text('Image Not available'),
                                    //     );
                                    //   },
                                    // ),
                                    FadeInImage.assetNetwork(
                                      placeholder: 'loader.gif',
                                      image: map['imageURL'] == ""
                                          ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299"
                                          : map['imageURL'],
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
                                        uid == "1bmm6EK0igbYxFadjCiN4xIUl612" ? Container(
                                          height: 50,
                                          width: 50,
                                          child: InkWell(
                                            child: Icon(Icons.edit),
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => DishDetails(restaurantID: document.id,)));
                                            },
                                          ),
                                        ) : Container(),
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
                                  ],
                                ),
                              ),
                              subtitle: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Text(map['categories'].length > 30 ? map['categories'].substring(0, 30) : map['categories']),
                                    Spacer(),
                                    Text("\u20b9${map['pricePerPerson']} for one", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DishPage(restaurantID: document.id,)));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );

                // return Column(
                //   children: [
                //   Card(
                //   elevation: 3,
                //   child: Column(
                //     children: [
                //       Image.network(map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'],),
                //       ListTile(
                //         title: Container(
                //           child: Row(
                //             children: [
                //               Text(map['name']),
                //               InkWell(
                //                 child: Icon(Icons.edit),
                //                 onTap: (){
                //                   Navigator.push(context, MaterialPageRoute(builder: (context) => DishDetails(restaurantID: document.id,)));
                //                 },
                //               )
                //             ],
                //           ),
                //         ),
                //         trailing: Container(
                //           child: Column(
                //             children: [
                //               Container(
                //                 height: 28,
                //                 width: 50,
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     Text(map['ratings'].toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                //                     Icon(Icons.star, color: Colors.white, size: 15,)
                //                   ],
                //                 ),
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(8),
                //                   color: Colors.green[800],
                //                 ),
                //               ),
                //               SizedBox(height: 6,),
                //               Text("\u20b9${map['pricePerPerson']} for one", style: TextStyle(color: Colors.grey),),
                //             ],
                //           ),
                //         ),
                //         subtitle: Text(map['categories']),
                //         onTap: (){
                //           Navigator.push(context, MaterialPageRoute(builder: (context) => DishPage(restaurantID: document.id,)));
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                //     SizedBox(height: 10,)
                //   ],
                // );
              }).toList(),
            ),
          );
        },
    );
  }
}
