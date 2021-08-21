import 'package:adf2021/Authentication/LoginPage.dart';
import 'package:adf2021/Authentication/LoginPageRestaurant.dart';
import 'package:adf2021/Authentication/RegisterPage.dart';
import 'package:adf2021/Authentication/RegisterPageRestaurant.dart';
import 'package:adf2021/Authentication/SplashPageRestaurant.dart';
import 'package:adf2021/Expanded.dart';
import 'package:adf2021/ImagePickerTask.dart';
import 'package:adf2021/JohnJack/JohnJack.dart';
import 'package:adf2021/Multiplication.dart';
import 'package:adf2021/News/profile.dart';
import 'package:adf2021/News/homePage.dart';
import 'package:adf2021/Authentication/SplashPage.dart';
import 'package:adf2021/Reminder/reminder.dart';
import 'package:adf2021/Restaurant/AddRestaurants.dart';
import 'package:adf2021/Restaurant/DishPage.dart';
import 'package:adf2021/Restaurant/RestaurantPage.dart';
import 'package:adf2021/UserProfile/UserProfilepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence
void main() async{
  // to execute the app created by us
  // MyApp -> Object
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
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
        // '/': (context)=> SplashPage(),
        // '/': (context) => BricksPage(),
        '/': (context) => SplashPageR(),
        '/login': (context) => LoginPageR(),
        '/register' : (context) => RegisterPageR(),
        '/addRestaurant': (context) => RestaurantDetails(),
        '/restaurant' : (context) => RestaurantsPage(),
        '/profile': (context) => UserProfilePage(),
        '/home': (context) => HomePage(),
        // '/profile' : (context) => ProfilePage(),
        // '/login' : (context) => LoginPage(),
        '/conclusion' : (context) => ConclusionPage(),
        '/imagePicker' : (context) => ImagePickerPage(),
        // '/dishes': (context) => DishPage(),
      },
      initialRoute: '/',
    );
  }
}

// class HomePage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Page1();
//   }
// }