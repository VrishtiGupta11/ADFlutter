import 'package:adf2021/CustomWidgets/Counter.dart';
import 'package:adf2021/Restaurant/razorpay-payment.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var paymentMethod = '';
  double total = 0;

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
                // IconButton(onPressed: (){
                //   FirebaseAuth.instance.signOut();
                //   Navigator.pushReplacementNamed(context, '/login');
                // }, icon: Icon(Icons.logout)),
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
                // IconButton(onPressed: (){
                //   FirebaseAuth.instance.signOut();
                //   Navigator.pushReplacementNamed(context, '/login');
                // }, icon: Icon(Icons.logout)),
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
                // int len = snapshot.data.docs.length;
                map['docID'] = document.id.toString();
                total += map['totalPrice'];

                return Column(
                  children: [
                    Container(
                      height: 135,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 5,
                          color: Colors.grey.shade100,
                        )],
                      ),
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 80,
                            margin: EdgeInsets.only(right: 5, top: 5, left: 5, bottom: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'loader.gif',
                              image: map['imageURL'] == ""
                                  ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FDefaultRestaurant.png?alt=media&token=afda153c-6bbe-415c-b4b1-a12a37b262d1"
                                  : map['imageURL'],
                              // image: map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'],
                              // imageScale: 1,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text('Image Not Available'),
                                );
                              },
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) {
                                return Center(
                                  child: Text('Loading Image'),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, left: 2.5, right: 5, top: 5),
                            padding: EdgeInsets.only(bottom: 5, left: 2.5, right: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(map['name'], style: TextStyle(fontSize: 16,),),
                                Text(map['totalPrice'].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    for(double i = 1; i<=map['ratings']; i++)
                                      Icon(Icons.star, color: Colors.orangeAccent, size: 15,),
                                    (10*map['ratings'])%10 != 0?
                                    ShaderMask(
                                      blendMode: BlendMode.srcATop,
                                      shaderCallback: (Rect rect) {
                                        return LinearGradient(
                                          stops: [0, (5 - map['ratings'])*100],
                                          colors: [
                                            Colors.orangeAccent,
                                            Colors.white.withOpacity(1),
                                          ],
                                        ).createShader(rect);
                                      },
                                      child: Icon(Icons.star, size: 15, color: Colors.white,),
                                    ) : Container(),
                                    // Spacer(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Counter(dish: map,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                  ],
                );

                // return Container(
                //   // height: 300,
                //   width: 100,
                //   margin: EdgeInsets.all(15),
                //   padding: EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [BoxShadow(blurRadius: 5)],
                //
                //   ),
                //   child: Column(
                //     children: [
                //       Container(
                //         height: 200,
                //         // child: Image.network(map['imageURL'],),
                //         child: FadeInImage.assetNetwork(
                //           placeholder: 'loader.gif',
                //           image: map['imageURL'] == "" ? "https://firebasestorage.googleapis.com/v0/b/adflutter1.appspot.com/o/restaurants%2FRestaurant.png?alt=media&token=98f6c77f-3427-4a43-bce2-9201e7da9299": map['imageURL'],
                //           imageErrorBuilder: (context, error, stackTrace) {
                //             return Center(
                //               child: Text('Image Not Available'),
                //             );
                //           },
                //           placeholderErrorBuilder: (context, error, stackTrace) {
                //             return Center(
                //               child: Text('Loading Image'),
                //             );
                //           },
                //         ),
                //       ),
                //       SizedBox(height: 15,),
                //       Container(
                //         child: Row(
                //           children: [
                //             Container(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(map['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                //                   Text(map['totalPrice'].toString(), style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),),
                //                 ],
                //               ),
                //             ),
                //             Spacer(),
                //             Counter(dish: map,),
                //             // CounterWidget(dish: map,),
                //           ],
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // );

              }).toList(),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(16),
              height: 120,
              child: Column(
                children: [
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //
                  //   ),
                  // ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () async{
                              paymentMethod = await Navigator.pushNamed(context, '/paymentMethods') as String;
                              setState(() {
                                total = 0;
                              });
                            },
                            child: Text('Select Payment Method'),
                          ),
                          Text(paymentMethod),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          OutlinedButton(
                              onPressed: () async{
                                if(paymentMethod.isNotEmpty){
                                  int result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RazorpayPaymentPage(amount: total),));
                                  if(result == 1){
                                    // Save the data i.e. Dishes as Order in Orders Collection under User
                                    // Order Object ->
                                    // 1. List of Dishes   2. Total   3. Address   4. Restaurant Details
                                  }

                                  // if(paymentMethod == 'Razor Pay'){
                                  //
                                  // }else if(paymentMethod == 'Paytm'){
                                  //
                                  // }else{
                                  //
                                  // }
                                }
                              },
                              child: Text('Place Order')
                          ),
                          Text('\u20b9$total'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}