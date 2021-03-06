import 'package:adf2021/CustomWidgets/Counter.dart';
import 'package:adf2021/Provider/data-provider.dart';
import 'package:adf2021/Restaurant/razorpay-payment.dart';
import 'package:adf2021/Restaurant/success.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var paymentMethod = 'Cash On Delivery';
  var cartTotal = {};
  var selectedAddress = '';
  Map dishes = {};
  // late int orderSize;

  // getOrderSize(){
  //   FirebaseFirestore.instance.collection('users').doc(Util.appUser!.uid).collection('orders').get().then((value) {orderSize = value.size;});
  //   return orderSize;
  // }

  fetchCart(){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('cart').snapshots();
    return stream;
  }

  fetchAddresses(){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('users').doc(Util.appUser!.uid).collection('addresses').snapshots();
    return stream;
  }

  getCartTotal(){
    double total = 0;
    cartTotal.values.forEach((element) {
      total += element;
      print("total = $total");
    });
    return total;
  }

  placeOrder(){

    Map<String, dynamic> order = Map();

    List li = [];
    dishes.values.forEach((element) {li.add(element);});

    order['dishes'] = li;
    order['total'] = getCartTotal();
    // order['restaurantID'] =
    order['address'] = selectedAddress;
    // order['orderNo'] = (context.watch()<DataProvider>(context, listen: false).orders == null)? 0 : context.watch<DataProvider>().orders!.length;
    // order['orderNo'] = getOrderSize();
    order['timestamp'] = DateTime.now();

    FirebaseFirestore.instance
        .collection('users')
        .doc(Util.appUser!.uid)
        .collection('orders')
        .doc()
        .set(order);
  }

  clearCart(){
    dishes.values.forEach((dish) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(Util.appUser!.uid)
          .collection('cart')
          .doc(dish['docID'])
          .delete();
    });
  }
  
  navigateToSuccess(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessPage(message: 'Your Order of \u20b9${getCartTotal()} has been placed', title: 'Thank you', flag: true),));
  }

  navigateToError(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessPage(message: 'Please try again', title: 'Order not Placed!', flag: false),));
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
                IconButton(onPressed: () {
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
            body: ListView(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
                    // int len = snapshot.data.docs.length;
                    map['docID'] = document.id.toString();
                    cartTotal[map['docID']] = map['totalPrice'];

                    dishes[map['docID']] = map;
                    // print(snapshot.data.docs.length);
                    // total += map['totalPrice'];

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
                                    Text(map['price'].toString() + '*' + map['quantity'].toString() + '=' + map['totalPrice'].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        for(double i = 1; i<=map['ratings']; i++)
                                          Icon(Icons.star, color: Colors.orangeAccent, size: 15,),
                                        (10*map['ratings'])%10 != 0?
                                        ShaderMask(
                                          blendMode: BlendMode.srcATop,
                                          shaderCallback: (Rect rect) {
                                            return LinearGradient(
                                              // stops: [0, (5 - map['ratings'])*100],
                                              stops: [0, ((10*map['ratings'])%10) / 10],
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



                  }).toList(),
                ),
                Container(
                  height: 172,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.green,),
                          Text('Delivery at $selectedAddress'),
                        ],
                      ),
                      Divider(thickness: 5,),
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(5),
                        color: Colors.yellow.shade50,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Item Total', style: TextStyle(color: Colors.grey),),
                                Spacer(),
                                Text(snapshot.data.docs.length.toString(), style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                            // Divider(),
                            Row(
                              children: [
                                Text('Discount', style: TextStyle(fontSize: 12, color: Colors.lightBlueAccent),),
                                Spacer(),
                                Text('Discount', style: TextStyle(fontSize: 12, color: Colors.lightBlueAccent),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Grand Total', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                                Spacer(),
                                Text(getCartTotal().toString(), style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: fetchAddresses(),
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
                      return Container(
                        margin: EdgeInsets.all(20),
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.redAccent.shade100,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/addAddress');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.5,
                                child: Text('Add Address', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.3,
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else{
                      List<DocumentSnapshot> snapshots = snapshot.data!.docs;
                      List<DropdownMenuItem<String>> tiles = [];
                      snapshots.forEach((document) {
                        Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
                        if(selectedAddress == ''){
                          selectedAddress = map['label'];
                        }
                        tiles.add(
                          DropdownMenuItem(
                            child: Text(map['label'], style: TextStyle(fontSize: 14),),
                            value: map['label'],
                          ),
                        );
                      });
                      return Container(
                        height: 200,
                        padding: EdgeInsets.all(16),
                        // margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.place, color: Colors.green,),
                                Text('Select Address'),
                              ],
                            ),
                            Divider(thickness: 5,),
                            DropdownButtonFormField(
                              items: tiles,
                              decoration: InputDecoration.collapsed(hintText: 'Select Address'),
                              hint: Text('Select Address'),
                              value: selectedAddress,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddress = value as String;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(16),
              height: 96,
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              paymentMethod =await Navigator.pushNamed(context, '/paymentMethods') as String;
                              setState(() {});
                            },
                            child: Text('Select Payment Method', style: TextStyle(color: Colors.redAccent),),
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
                                  int result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RazorpayPaymentPage(amount: getCartTotal()*100),));
                                  if(result == 1){
                                    // Save the data i.e. Dishes as Order in Orders Collection under User
                                    // Order Object ->
                                    // 1. List of Dishes   2. Total   3. Address   4. Restaurant Details
                                    print('Placing Order');
                                    placeOrder();
                                    print('Order Placed');
                                    clearCart();
                                    navigateToSuccess();
                                  }
                                  else{
                                    navigateToError();
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
                              child: Text('Place Order', style: TextStyle(color: Colors.redAccent),),
                          ),
                          Text('\u20b9${getCartTotal()}'),
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