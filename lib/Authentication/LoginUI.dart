import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        // Color(0x0C693D),
                        // Color(0x3CA076),
                        Colors.green,
                        Colors.lightGreen,
                      ],
                      tileMode: TileMode.clamp
                  ),
                ),
              ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height/2,
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Card(
            margin: EdgeInsets.fromLTRB(25, 150, 25, 150),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Icon(Icons.login_rounded, size: 70,),
                  SizedBox(height: 15,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 12,
                      ),
                      hintText: 'Username',
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    selectionHeightStyle: BoxHeightStyle.max,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 12,
                      ),
                      hintText: 'Password',
                    ),
                  ),
                  // OutlinedButton(onPressed: (){}, child: Text("Login"),)
                  SizedBox(height: 15,),
                  Container(
                    height: 40,
                    width: 300,
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text("Login", style: TextStyle(color: Colors.white),),],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
}