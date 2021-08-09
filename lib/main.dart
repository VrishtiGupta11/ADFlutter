import 'package:adf2021/News/profile.dart';
import 'package:adf2021/News/homePage.dart';
import 'package:adf2021/News/splashPage.dart';
import 'package:flutter/material.dart';

// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence
void main() {
  // to execute the app created by us
  // MyApp -> Object
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context)=> SplashPage(),
        '/home': (context) => HomePage(),
        '/profile' : (context) => ProfilePage()
      },
      initialRoute: '/',
    );
  }
}

// class HomePage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Profile"),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 88, 139, 92),
//       ),
//       body: ProfilePage(),
//     );
//   }
// }