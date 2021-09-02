import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 84, 32, 95);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.white38),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
         title: Text('My APP'),
          centerTitle: true,
        ),
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Text('Welcome to MyApp'),
        SizedBox(height: 10,),
        Divider(),
        Text("Version : 7.1.1")],
      ),
    );
  }
}
