import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Generally Splash page contains app name, logo etc.

class SplashPageR extends StatelessWidget {
  const SplashPageR({Key? key}) : super(key: key);

  navigateToHome(BuildContext context){

    var uid = FirebaseAuth.instance.currentUser != null? FirebaseAuth.instance.currentUser!.uid : "";

    Future.delayed(
        Duration(seconds: 5),
            (){
          // Swiggy Bug => When on splash page, if user goes back and at sametime page routes to homepage, So instead of going back it will navigate on splash page
          // Navigator.pushNamed(context, '/home');   // Here homepage will come on top of splash page
          Navigator.pushReplacementNamed(context, '/login');
          if(uid.isNotEmpty){
            if(uid == "1bmm6EK0igbYxFadjCiN4xIUl612"){
              Navigator.pushReplacementNamed(context, '/addRestaurant');
            }else{
              Navigator.pushReplacementNamed(context, '/restaurant');
            }
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    navigateToHome(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("hamburger.png"),
            SizedBox(height: 8,),
            Divider(),
            SizedBox(height: 4,),
            Text("Your Hungry Point!", style: TextStyle(color: Colors.grey, fontSize: 16),),
            SizedBox(height: 4,),
            // Text("Here comes the latest news for you!", style: TextStyle(color: Colors.blueGrey, fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
