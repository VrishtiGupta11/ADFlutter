import 'package:flutter/material.dart';

// Generally Splash page contains app name, logo etc.

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  navigateToHome(BuildContext context){
    Future.delayed(
        Duration(seconds: 5),
            (){
          // Swiggy Bug => When on splash page, if user goes back and at sametime page routes to homepage, So instead of going back it will navigate on splash page
          // Navigator.pushNamed(context, '/home');   // Here homepage will come on top of splash page
          Navigator.pushReplacementNamed(context, '/home');   // Here homepage will replace the splash page
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
            Image.asset("news.png"),
            SizedBox(height: 8,),
            Divider(),
            SizedBox(height: 4,),
            Text("Here comes the latest news for you!", style: TextStyle(color: Colors.orangeAccent, fontSize: 16),),
            SizedBox(height: 4,),
            // Text("Here comes the latest news for you!", style: TextStyle(color: Colors.blueGrey, fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
