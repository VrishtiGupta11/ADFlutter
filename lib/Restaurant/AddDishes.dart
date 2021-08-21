import 'package:adf2021/Model/Dish.dart';
import 'package:adf2021/Restaurant/DishPage.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DishDetails extends StatefulWidget {

  String? restaurantID;

  DishDetails({Key? key, this.restaurantID}) : super(key: key);

  @override
  _DishDetailsState createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {

  addDishes(BuildContext context){
    Dish dishDetails = Dish(
      name: nameController.text,
      imageURL: '',
      ratings: double.parse(ratingsController.text),
      discountType: int.parse(discountTypeController.text),
      flatDiscount: double.parse(flatDiscountController.text),
      percentDiscount: double.parse(percentageDiscountController.text),
      price: double.parse(priceController.text),
    );
    var dataToSave = dishDetails.toMap();

    FirebaseFirestore.instance.collection('restaurants').doc(widget.restaurantID).collection('dishes').doc().set(dataToSave).then((value) => Navigator.pushNamed(context, '/restaurant'));
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingsController = TextEditingController();
  TextEditingController discountTypeController = TextEditingController();
  TextEditingController flatDiscountController = TextEditingController();
  TextEditingController percentageDiscountController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(APP_NAME),
        centerTitle: true,
        backgroundColor: Colors.black45,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: // Column(
        // children: [
        //   SizedBox(height: 25,),
          // Expanded(child: Image.asset("foodImage.png", width: 350),),
          // Container(
          // child:
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("foodImage.png", width: 350),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        labelText: "Dish Name",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        labelText: "Price",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: discountTypeController,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        labelText: "Discount Type",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: ratingsController,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        labelText: "Ratings",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: percentageDiscountController,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        labelText: "Percentage Discount",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: flatDiscountController,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        labelText: "Flat Discount",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextButton(
                      onPressed: (){
                        addDishes(context);
                      },
                      child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 20),),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DishPage(restaurantID: widget.restaurantID,)));
                      },
                      child: Text("View Dishes", style: TextStyle(color: Colors.white, fontSize: 20),),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        // ],
      // ),
    );
  }
}
