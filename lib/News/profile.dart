import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);


  setWidgets(){
    return Column(
      children: [
        SizedBox(height: 10,),
        Text("Your Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(height: 50,),
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orangeAccent,
            image: DecorationImage(
              image: NetworkImage("https://images.unsplash.com/photo-1627883749168-c2c8f0b9c5c7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4N3x8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Text("John Watson", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
        SizedBox(height: 10,),
        Text("Frontend Developer with 2 years of experience", style: TextStyle(fontSize: 15, color: Colors.grey[600]),),
        SizedBox(
          height: 30,
        ),
        Container(
          width: 290,
          height: 150,
          color: Color.fromARGB(100, 239, 214, 159),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 5),
                  Column(children: [Text("Followers", style: TextStyle(color: Colors.deepOrange[300], fontSize: 15),)]),
                  SizedBox(width: 45),
                  Column(children: [Text("Followings", style: TextStyle(color: Colors.deepOrange[300], fontSize: 15),)],),
                  SizedBox(width: 45),
                  Column(children: [Text("Articles", style: TextStyle(color: Colors.deepOrange[300], fontSize: 15),)],)
                ],
              ),
              SizedBox(height: 10,),
              Row(children: [
                SizedBox(width: 30),
                Column(children: [Text("12", style: TextStyle(color: Colors.orange, fontSize: 15),)],),
                SizedBox(width: 95),
                Column(children: [Text("12", style: TextStyle(color: Colors.orange, fontSize: 15),)],),
                SizedBox(width: 90),
                Column(children: [Text("12", style: TextStyle(color: Colors.orange, fontSize: 15),)],)
              ],),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Container(
                  height: 35,
                  width: 110,
                  child: Center(
                    child: Text("Explore More", style: TextStyle(color: Colors.white),),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(18)
                  ),
                ),
                onTap: (){},
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWS Book"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: Icon(Icons.home),
              tooltip: 'Home Page',
          ),
          IconButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/profile');
            },
            icon: Icon(Icons.account_box),
            tooltip: "Your Profile",
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Center(
            child: setWidgets(),
          ),
        ],
      ),
    );
  }
}
