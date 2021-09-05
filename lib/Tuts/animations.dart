import 'dart:math';
import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {

  Color color = Colors.green;
  double borderRadius = 1;
  double margin = 1;

  void updateAttributes(){
    color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
    borderRadius = Random().nextDouble() * 64;
    margin = Random().nextDouble() * 64;
  }

  // Acting as a constructor
  // Executed before build method

  @override
  void initState() {
    super.initState();
    updateAttributes();
  }

  animateContainer(){
    setState(() {
      updateAttributes();
    });
  }

  // Acting as destructor
  // Task to do when we pop up the widget from UI
  @override
  void dispose() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations Introduction'),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              width: 256,
              height: 256,
              margin: EdgeInsets.all(margin),
              duration: Duration(milliseconds: 1000),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            SizedBox(height: 24,),
            TextButton(
              onPressed: (){
                updateAttributes();
              },
              child: Text('Animate Controller')),
          ],
        ),
      ),
    );
  }
}
