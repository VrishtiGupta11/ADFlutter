import 'package:adf2021/Model/Dish.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {

  Map? dish;

  Counter({Key? key, this.dish}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  var initialValue = 0;

  fetchDishes(){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('cart').snapshots();
    return stream;
  }
  updateDishInCart(){

    Dish cartDish = Dish(
      name: widget.dish!['name'],
      price: widget.dish!['price'],
      quantity: initialValue,
      totalPrice: widget.dish!['price']*initialValue,
      imageURL: widget.dish!['imageURL'],
    );

    FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('cart').doc(widget.dish!['docID']).set(cartDish.toMap());
  }

  deleteDishFromCart() {
    FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).collection('cart').doc(widget.dish!['docID']).delete();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: fetchDishes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasError){
          return Center(
            child: Text("Something Went Wrong", style: TextStyle(color: Colors.red),),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Container(),
          );
        }
        List snapshots = snapshot.data.docs;
        snapshots.forEach((document) {
          Map map = document.data();
          map['docID'] = document.id.toString();
          if(map['docID'] == widget.dish!['docID']){
            initialValue = map['quantity'];
          }
        });

        return Container(
            width: 150,
            height: 40,
            child: (initialValue==0) ? OutlinedButton(
              // style: OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey[200]),
              onPressed: (){
                setState(() {
                  initialValue++;
                  updateDishInCart();
                });
              },
              child: Text("ADD", style: TextStyle(color: Colors.black, ),),

            ) : Container(
              height: 50,
              width: 150,
              // color: Colors.blueGrey[200],
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: (){
                      setState(() {
                        if(initialValue<=0){
                          initialValue = 0;
                        }else if(initialValue == 1){
                          initialValue--;
                          updateDishInCart();
                          deleteDishFromCart();
                        }else{
                          initialValue--;
                          updateDishInCart();
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text("-", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),],
                      ),
                    ),
                  ),

                  Text(initialValue.toString()),
                  // Text(map['quantity'].toString()),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        initialValue++;
                        updateDishInCart();
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text("+", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),],
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );


  }
}
