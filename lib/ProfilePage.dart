import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  leftWidget(){
    return Container(
      height: 100,
      width: 50,
      decoration: BoxDecoration(
          color: Color.fromARGB(130, 228, 255, 171),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50))
      ),
    );
  }

  setWidgets(){
    return Column(
      children: [
        SizedBox(height: 150,),
        Text("John Watson", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
        SizedBox(height: 10,),
        Text("Frontend Developer with 2 years of experience", style: TextStyle(fontSize: 15, color: Colors.grey[600]),),
        SizedBox(
          height: 30,
        ),
        Container(
          width: 290,
          height: 150,
          color: Color.fromARGB(130, 228, 255, 171),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 5),
                  Column(children: [Text("Followers", style: TextStyle(color: Color.fromARGB(
                      255, 88, 139, 92), fontSize: 15),)]),
                  SizedBox(width: 45),
                  Column(children: [Text("Followings", style: TextStyle(color: Color.fromARGB(
                      255, 88, 139, 92), fontSize: 15),)],),
                  SizedBox(width: 45),
                  Column(children: [Text("Articles", style: TextStyle(color: Color.fromARGB(
                      255, 88, 139, 92), fontSize: 15),)],)
                ],
              ),
              SizedBox(height: 10,),
              Row(children: [
                SizedBox(width: 30),
                Column(children: [Text("12", style: TextStyle(color: Colors.green, fontSize: 15),)],),
                SizedBox(width: 95),
                Column(children: [Text("12", style: TextStyle(color: Colors.green, fontSize: 15),)],),
                SizedBox(width: 90),
                Column(children: [Text("12", style: TextStyle(color: Colors.green, fontSize: 15),)],)
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
                    color: Color.fromARGB(255, 88, 139, 92),
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
    return Center(
      child: setWidgets(),
    );
  }
}
