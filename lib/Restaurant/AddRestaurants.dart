import 'package:adf2021/Model/Restaurant.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({Key? key}) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {

  addRestaurantDetails(BuildContext context){
    Restaurant restaurantDetails = Restaurant(
        name: nameController.text,
        categories: categoriesController.text,
        pricePerPerson: int.parse(pricePerPersonController.text),
        ratings: double.parse(ratingsController.text),
        imageURL: "",
    );
    var dataToSave = restaurantDetails.toMap();

    FirebaseFirestore.instance.collection("restaurants").doc().set(dataToSave).then((value) => Navigator.pushNamed(context, '/'));
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  TextEditingController pricePerPersonController = TextEditingController();
  TextEditingController ratingsController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(Util.APP_NAME),
        centerTitle: true,
        backgroundColor: Colors.black45,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 500,
            width: 300,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("foodImage.png", width: 350),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    labelText: "Restaurant Name",
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
                  controller: categoriesController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    labelText: "Categories",
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
                  controller: pricePerPersonController,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    labelText: "Price Per Person",
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
                SizedBox(height: 20,),
                TextButton(
                  onPressed: (){
                    addRestaurantDetails(context);
                  },
                  child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 20),),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/restaurant');
                  },
                  child: Text("View Restaurants", style: TextStyle(color: Colors.white, fontSize: 20),),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
