import 'package:adf2021/Authentication/LoginPage.dart';
import 'package:adf2021/Authentication/LoginPageRestaurant.dart';
import 'package:adf2021/Authentication/RegisterPage.dart';
import 'package:adf2021/Authentication/RegisterPageRestaurant.dart';
import 'package:adf2021/Authentication/SplashPageRestaurant.dart';
import 'package:adf2021/Tuts/Expanded.dart';
import 'package:adf2021/Tuts/ImagePickerTask.dart';
import 'package:adf2021/JohnJack/JohnJack.dart';
import 'package:adf2021/Tuts/Multiplication.dart';
import 'package:adf2021/News/profile.dart';
import 'package:adf2021/News/homePage.dart';
import 'package:adf2021/Authentication/SplashPage.dart';
import 'package:adf2021/Reminder/reminder.dart';
import 'package:adf2021/Restaurant/AddRestaurants.dart';
import 'package:adf2021/Restaurant/DishPage.dart';
import 'package:adf2021/Restaurant/RestaurantPage.dart';
import 'package:adf2021/Restaurant/cart-page.dart';
import 'package:adf2021/Tuts/fetchCurrentLocation.dart';
import 'package:adf2021/Tuts/google-maps-with-location.dart';
import 'package:adf2021/UserProfile/UserProfilepage.dart';
import 'package:adf2021/UserProfile/add-address.dart';
import 'package:adf2021/UserProfile/manage-orders.dart';
import 'package:adf2021/UserProfile/manage-profile.dart';
import 'package:adf2021/UserProfile/show-addresses.dart';
import 'package:adf2021/Tuts/fetchCurrentLocation.dart';
import 'package:adf2021/Tuts/google-maps-with-location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;


void main() async{
  // to execute the app created by us
  // MyApp -> Object
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (!kIsWeb) {
  //   channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
        '/location': (context) => FetchCurrentLocationPage(),
        // '/dishes': (context) => DishPage(),
        '/googleMap': (context) => GoogleMapsPage(),
        '/addAddress': (context) => AddAddressPage(),
        '/address': (context) => UserAddressesPage(),
        '/cart': (context) => CartPage(),
        '/manageProfile': (context) => ManageProfilePage(),
        '/manageOrders': (context) => ManageOrdersPage(),
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