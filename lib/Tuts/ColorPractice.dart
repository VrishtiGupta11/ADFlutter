import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(),
      body: HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var background;
  Map colorsMap = {
    'Grey': Colors.grey,
    'Brown': Colors.brown,
    'Red': Colors.redAccent,
    'Blue': Colors.blueAccent,
    'Purple': Colors.deepPurple,
    'Green': Colors.greenAccent
  };
  getColors(){
    List colorsList = <Widget>[];
    colorsMap.forEach((key, value) {
      colorsList.add(InkWell(
        borderRadius: BorderRadius.circular(5),
        hoverColor: value,
        child: Column(
          children: [Text(key, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: value,
          ),), Divider()],
        ),
        onTap: (){
          setState(() {
            background = value;
          });
        },
      ));
    });
    return colorsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          children: getColors(),
        ),
      ),
    );
  }
}
