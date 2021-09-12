import 'package:adf2021/Restaurant/RestaurantPage.dart';
import 'package:adf2021/Util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RestaurantFilters extends StatefulWidget {
  const RestaurantFilters({Key? key}) : super(key: key);

  @override
  _RestaurantFiltersState createState() => _RestaurantFiltersState();
}

class _RestaurantFiltersState extends State<RestaurantFilters> {

  int idx = 0;

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
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/profile');
          }, icon: Icon(Icons.person)),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    for(int i=0; i<Util.tags.length; i++)
                      FilterChip(
                        backgroundColor: Colors.blueGrey.shade100,
                        selectedColor: Colors.red.shade50,
                        side: idx == i? BorderSide(
                            color: Colors.redAccent.shade100
                        ) : BorderSide.none,
                        label: Text(Util.tags[i], style: TextStyle(fontWeight: FontWeight.w300),),
                        selected: idx == i,
                        onSelected: (value) {
                          setState(() {
                            idx = value ? i : -1;
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          RestaurantsPage(tag: Util.tags[idx],),
        ],
      ),

    );


  }
}
